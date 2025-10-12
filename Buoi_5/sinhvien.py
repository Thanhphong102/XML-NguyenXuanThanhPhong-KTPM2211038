from lxml import etree

# Đọc file XML (đảm bảo file sinhvien.xml được lưu UTF-8)
tree = etree.parse("sinhvien.xml")
root = tree.getroot()

# 1. Lấy tất cả sinh viên
print("1. Lấy tất cả các sinh viên")
for s in root.xpath("/school/student"):
    print(f"id: {s.find('id').text}, Tên: {s.find('name').text}, Ngày sinh: {s.find('date').text}")

# 2. Liệt kê tên tất cả sinh viên
print("\n2. Liệt kê tên tất cả sinh viên")
print(root.xpath("/school/student/name/text()"))

# 3. Lấy tất cả id của sinh viên
print("\n3. Lấy tất cả id của sinh viên")
print(root.xpath("/school/student/id/text()"))

# 4. Lấy ngày sinh của sinh viên có id = 'SV01'
print("\n4. Lấy ngày sinh của sinh viên có id = 'SV01'")
print(root.xpath("/school/student[id='SV01']/date/text()"))

# 5. Lấy các khóa học
print("\n5. Lấy các khóa học")
print(root.xpath("/school/enrollment/course/text()"))

# 6. Lấy toàn bộ thông tin của sinh viên đầu tiên
print("\n6. Lấy toàn bộ thông tin của sinh viên đầu tiên")
s = root.xpath("/school/student[1]")[0]
print(f"id: {s.find('id').text}, Tên: {s.find('name').text}, Ngày sinh: {s.find('date').text}")

# 7. Lấy mã sinh viên đăng ký khóa học 'Vatly203'
print("\n7. Lấy mã sinh viên đăng ký khóa học 'Vatly203'")
print(root.xpath("/school/enrollment[course='Vatly203']/studentRef/text()"))

# 8. Lấy tên sinh viên học môn 'Toan101'
print("\n8. Lấy tên sinh viên học môn 'Toan101'")
print(root.xpath("/school/student[id=string(/school/enrollment[course='Toan101']/studentRef)]/name/text()"))

# 9. Lấy tên sinh viên học môn 'Vatly203'
print("\n9. Lấy tên sinh viên học môn 'Vatly203'")
tsvL = root.xpath("/school/student[id=string(/school/enrollment[course='Vatly203']/studentRef)]/name/text()")
print(tsvL)

# 10. Lấy ngày sinh của sinh viên có id='SV01'
print("\n10. Lấy ngày sinh của sinh viên có id='SV01'")
print(root.xpath("/school/student[id='SV01']/date/text()")[0])

# 11. Lấy tên và ngày sinh của mọi sinh viên sinh năm 1997
print("\n11. Lấy tên và ngày sinh của mọi sinh viên sinh năm 1997")
for s in root.xpath("/school/student[starts-with(date, '1997')]"):
    print(f"{s.find('name').text} - {s.find('date').text}")

# 12. Lấy tên của các sinh viên có ngày sinh trước năm 1998
print("\n12. Lấy tên của các sinh viên có ngày sinh trước năm 1998")
for s in root.xpath("/school/student[starts-with(date, '1996') or starts-with(date, '1997')]"):
    print("-", s.find('name').text)

# 13. Đếm tổng số sinh viên
print("\n13. Đếm tổng số sinh viên")
print(int(root.xpath("count(/school/student)")))

# 14. Lấy tất cả sinh viên chưa đăng ký môn nào
print("\n14. Lấy tất cả sinh viên chưa đăng ký môn nào")
for name in root.xpath("/school/student[not(id=/school/enrollment/studentRef)]/name/text()"):
    print("-", name)

# 15. Lấy phần tử <date> anh em ngay sau <name> của SV01
print("\n15. Lấy phần tử <date> anh em ngay sau <name> của SV01")
print(root.xpath("/school/student[id='SV01']/name/following-sibling::date/text()")[0])

# 16. Lấy phần tử <id> anh em ngay trước <name> của SV02
print("\n16. Lấy phần tử <id> anh em ngay trước <name> của SV02")
print(root.xpath("/school/student[id='SV02']/name/preceding-sibling::id/text()")[0])

# 17. Lấy toàn bộ node <course> trong cùng một <enrollment> với studentRef='SV03'
print("\n17. Lấy toàn bộ node <course> trong cùng một <enrollment> với studentRef='SV03'")
for c in root.xpath("/school/enrollment[studentRef='SV03']/course/text()"):
    print("-", c)

# 18. Lấy sinh viên có họ là 'Trần'
print("\n18. Lấy sinh viên có họ là 'Trần'")
for name in root.xpath("/school/student[starts-with(name, 'Trần')]/name/text()"):
    print("-", name)

# 19. Lấy năm sinh của sinh viên SV01
print("\n19. Lấy năm sinh của sinh viên SV01")
date_str = root.xpath("/school/student[id='SV01']/date/text()")[0]
print(f"Kết quả: {date_str[:4]}")

