<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Kết quả truy vấn Quản lý Bàn ăn</title>
                <style>
                    body {
                    font-family: Arial, sans-serif;
                    background: #f5f5f5;
                    margin: 0;
                    padding: 0;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    }
                    h1 {
                    background: #4CAF50;
                    color: white;
                    padding: 20px;
                    width: 100%;
                    text-align: center;
                    margin: 0 0 20px 0;
                    }
                    table {
                    border-collapse: collapse;
                    width: 80%;
                    background: white;
                    margin-bottom: 30px;
                    box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
                    }
                    th, td {
                    border: 1px solid #ddd;
                    padding: 10px;
                    text-align: left;
                    }
                    th {
                    background: #f2f2f2;
                    text-transform: uppercase;
                    }
                    tr:nth-child(even) {background-color: #f9f9f9;}
                    h2 {
                    width: 80%;
                    margin-top: 30px;
                    background: #2196F3;
                    color: white;
                    padding: 10px;
                    text-align: left;
                    border-radius: 4px 4px 0 0;
                    }
                </style>
            </head>
            <body>
                <h1>Kết quả truy vấn dữ liệu</h1>
                
                <!-- 1. Danh sách bàn -->
                <h2>1. Danh sách tất cả các bàn</h2>
                <table>
                    <tr><th>STT</th><th>Số bàn</th><th>Tên bàn</th></tr>
                    <xsl:for-each select="QUANLY/BANS/BAN">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="SOBAN"/></td>
                            <td><xsl:value-of select="TENBAN"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 2. Danh sách nhân viên -->
                <h2>2. Danh sách nhân viên</h2>
                <table>
                    <tr><th>STT</th><th>Mã NV</th><th>Tên NV</th><th>SĐT</th><th>Địa chỉ</th><th>Giới tính</th></tr>
                    <xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="MANV"/></td>
                            <td><xsl:value-of select="TENV"/></td>
                            <td><xsl:value-of select="SDT"/></td>
                            <td><xsl:value-of select="DIACHI"/></td>
                            <td><xsl:value-of select="GIOITINH"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 3. Danh sách món -->
                <h2>3. Danh sách các món ăn</h2>
                <table>
                    <tr><th>STT</th><th>Mã món</th><th>Tên món</th><th>Giá</th><th>Hình ảnh</th></tr>
                    <xsl:for-each select="QUANLY/MONS/MON">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="MAMON"/></td>
                            <td><xsl:value-of select="TENMON"/></td>
                            <td><xsl:value-of select="GIA"/></td>
                            <td><xsl:value-of select="HINHANH"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 4. Thông tin NV02 -->
                <h2>4. Thông tin nhân viên NV02</h2>
                <table>
                    <tr><th>Mã NV</th><th>Tên NV</th><th>SĐT</th><th>Địa chỉ</th><th>Giới tính</th></tr>
                    <xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']">
                        <tr>
                            <td><xsl:value-of select="MANV"/></td>
                            <td><xsl:value-of select="TENV"/></td>
                            <td><xsl:value-of select="SDT"/></td>
                            <td><xsl:value-of select="DIACHI"/></td>
                            <td><xsl:value-of select="GIOITINH"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 5. Món giá > 50,000 -->
                <h2>5. Danh sách món ăn có giá &gt; 50,000</h2>
                <table>
                    <tr><th>STT</th><th>Mã món</th><th>Tên món</th><th>Giá</th></tr>
                    <xsl:for-each select="QUANLY/MONS/MON[GIA &gt; 50000]">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="MAMON"/></td>
                            <td><xsl:value-of select="TENMON"/></td>
                            <td><xsl:value-of select="GIA"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 6. Thông tin hóa đơn HD03 -->
                <h2>6. Thông tin hóa đơn HD03</h2>
                <table>
                    <tr><th>Số HĐ</th><th>Tên NV</th><th>Số bàn</th><th>Ngày lập</th><th>Tổng tiền</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD03']">
                        <tr>
                            <td><xsl:value-of select="SOHD"/></td>
                            <td><xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/></td>
                            <td><xsl:value-of select="SOBAN"/></td>
                            <td><xsl:value-of select="NGAYLAP"/></td>
                            <td><xsl:value-of select="TONGTIEN"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 7. Tên món trong HD02 -->
                <h2>7. Tên món ăn trong hóa đơn HD02</h2>
                <table>
                    <tr><th>STT</th><th>Tên món</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']/CTHDS/CTHD">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 8. Tên NV lập HD02 -->
                <h2>8. Tên nhân viên lập hóa đơn HD02</h2>
                <table>
                    <tr><th>Tên nhân viên</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']">
                        <tr>
                            <td><xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 9. Đếm số bàn -->
                <h2>9. Tổng số bàn</h2>
                <p><strong><xsl:value-of select="count(QUANLY/BANS/BAN)"/></strong></p>
                
                <!-- 10. Đếm số hóa đơn NV01 -->
                <h2>10. Số hóa đơn lập bởi NV01</h2>
                <p><strong><xsl:value-of select="count(QUANLY/HOADONS/HOADON[MANV='NV01'])"/></strong></p>
                
                <!-- 11. Món từng bán cho bàn 2 -->
                <h2>11. Danh sách món từng bán cho bàn số 2</h2>
                <table>
                    <tr><th>STT</th><th>Tên món</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN='2']/CTHDS/CTHD">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 12. Nhân viên lập hóa đơn bàn 3 -->
                <h2>12. Danh sách nhân viên từng lập hóa đơn cho bàn số 3</h2>
                <table>
                    <tr><th>STT</th><th>Tên nhân viên</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN='3']">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 13. Món ăn gọi nhiều hơn 1 lần -->
                <h2>13. Món ăn được gọi nhiều hơn 1 lần</h2>
                <table>
                    <tr><th>STT</th><th>Tên món</th><th>Tổng số lượng</th></tr>
                    <xsl:for-each select="QUANLY/MONS/MON">
                        <xsl:variable name="ma" select="MAMON"/>
                        <xsl:variable name="tong" select="sum(/QUANLY/HOADONS/HOADON/CTHDS/CTHD[MAMON=$ma]/SOLUONG)"/>
                        <xsl:if test="$tong &gt; 1">
                            <tr>
                                <td><xsl:value-of select="position()"/></td>
                                <td><xsl:value-of select="TENMON"/></td>
                                <td><xsl:value-of select="$tong"/></td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
                
                <!-- 14. Chi tiết hóa đơn HD04 -->
                <h2>14. Chi tiết hóa đơn HD04</h2>
                <table>
                    <tr>
                        <th>STT</th><th>Mã món</th><th>Tên món</th><th>Đơn giá</th><th>Số lượng</th><th>Thành tiền</th>
                    </tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD04']/CTHDS/CTHD">
                        <xsl:variable name="ma" select="MAMON"/>
                        <xsl:variable name="gia" select="/QUANLY/MONS/MON[MAMON=$ma]/GIA"/>
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="$ma"/></td>
                            <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=$ma]/TENMON"/></td>
                            <td><xsl:value-of select="$gia"/></td>
                            <td><xsl:value-of select="SOLUONG"/></td>
                            <td><xsl:value-of select="$gia * SOLUONG"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
