import os
from lxml import etree
import mysql.connector
from mysql.connector import Error

# Hàm validate XML với XSD
def validate_xml(xml_path, xsd_path):
    try:
        xmlschema_doc = etree.parse(xsd_path)
        xmlschema = etree.XMLSchema(xmlschema_doc)
        xml_doc = etree.parse(xml_path)
        if xmlschema.validate(xml_doc):
            print("XML hợp lệ với XSD.")
            return xml_doc
        else:
            print("XML không hợp lệ.")
            for error in xmlschema.error_log:
                print(f"Lỗi: {error.message} tại dòng {error.line}")
            return None
    except etree.XMLSchemaParseError as e:
        print(f"Lỗi parse XSD: {e}")
        return None
    except etree.XMLSyntaxError as e:
        print(f"Lỗi parse XML: {e}")
        return None

# Hàm kết nối MySQL
def connect_mysql():
    try:
        connection = mysql.connector.connect(
            host='localhost',       # Chỉnh sửa nếu cần
            user='root',            # Tên user MySQL
            password='',  # Mật khẩu MySQL
            database='ecommerce_db'  # Tên database
        )
        if connection.is_connected():
            print("Kết nối MySQL thành công.")
            return connection
    except Error as e:
        print(f"Lỗi kết nối MySQL: {e}")
        return None

# Hàm tạo bảng nếu chưa tồn tại
def create_tables(cursor):
    # Tạo bảng Categories
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS Categories (
            category_id VARCHAR(10) PRIMARY KEY,
            name VARCHAR(255) NOT NULL
        )
    """)
    # Tạo bảng Products
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS Products (
            product_id VARCHAR(10) PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            price DECIMAL(10, 2) NOT NULL,
            currency VARCHAR(3) NOT NULL,
            stock INT NOT NULL,
            category_id VARCHAR(10),
            FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        )
    """)
    print("Bảng Categories và Products đã được tạo nếu chưa tồn tại.")

# Hàm insert/update dữ liệu
def insert_data(cursor, xml_doc):
    # Sử dụng XPath để lấy categories
    categories = xml_doc.xpath('//categories/category')
    for cat in categories:
        cat_id = cat.get('id')
        cat_name = cat.text.strip()
        cursor.execute("""
            INSERT INTO Categories (category_id, name)
            VALUES (%s, %s)
            ON DUPLICATE KEY UPDATE name = %s
        """, (cat_id, cat_name, cat_name))
    
    # Sử dụng XPath để lấy products
    products = xml_doc.xpath('//products/product')
    for prod in products:
        prod_id = prod.get('id')
        cat_ref = prod.get('categoryRef')
        name = prod.find('name').text.strip()
        price_elem = prod.find('price')
        price = float(price_elem.text.strip())
        currency = price_elem.get('currency')
        stock = int(prod.find('stock').text.strip())
        cursor.execute("""
            INSERT INTO Products (product_id, name, price, currency, stock, category_id)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
                name = %s, price = %s, currency = %s, stock = %s, category_id = %s
        """, (prod_id, name, price, currency, stock, cat_ref,
              name, price, currency, stock, cat_ref))
    
    print("Dữ liệu đã được insert/update vào MySQL.")

# Hàm chính
def main(xml_path, xsd_path):
    xml_doc = validate_xml(xml_path, xsd_path)
    if xml_doc is None:
        return
    
    connection = connect_mysql()
    if connection is None:
        return
    
    cursor = connection.cursor()
    create_tables(cursor)
    insert_data(cursor, xml_doc)
    connection.commit()
    cursor.close()
    connection.close()

# Chạy ứng dụng
if __name__ == "__main__":
    xml_file = "catalog.xml"  # Đường dẫn file XML
    xsd_file = "catalog.xsd"  # Đường dẫn file XSD
    if os.path.exists(xml_file) and os.path.exists(xsd_file):
        main(xml_file, xsd_file)
    else:
        print("File XML hoặc XSD không tồn tại.")