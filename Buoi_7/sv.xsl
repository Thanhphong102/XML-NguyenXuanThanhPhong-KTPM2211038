<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Buoi_7 - Bai_1</title>
                <style>
                    body {
                    font-family: "Segoe UI", Tahoma, sans-serif;
                    background: linear-gradient(135deg, #6dd5fa, #2980b9);
                    color: #333;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    flex-direction: column;
                    padding: 30px;
                    }
                    h1 {
                    text-align: center;
                    color: #fff;
                    margin-bottom: 30px;
                    text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
                    }
                    h2 {
                    text-align: center;
                    margin-top: 40px;
                    color: #fff;
                    background-color: rgba(0, 0, 0, 0.2);
                    padding: 10px 20px;
                    border-radius: 10px;
                    width: fit-content;
                    }
                    table {
                    border-collapse: collapse;
                    margin: 20px auto;
                    width: 70%;
                    background: white;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                    border-radius: 10px;
                    overflow: hidden;
                    }
                    th {
                    background-color: #2980b9;
                    color: white;
                    padding: 12px;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                    }
                    td {
                    padding: 10px;
                    text-align: center;
                    border-bottom: 1px solid #ddd;
                    }
                    tr:nth-child(even) {
                    background-color: #f2f2f2;
                    }
                    tr:hover {
                    background-color: #dceefc;
                    transition: 0.2s;
                    }
                    th:first-child, td:first-child {
                    border-left: none;
                    }
                </style>
            </head>
            <body>
                <h1>📋 Kết quả truy vấn sinh viên</h1>
                
                <!-- 1. Liệt kê thông tin tất cả sinh viên -->
                <h2>1. Danh sách sinh viên (Mã - Họ tên)</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ tên</th>
                    </tr>
                    <xsl:apply-templates select="school/student"/>
                </table>
                
                <!-- 2. Danh sách sinh viên sắp xếp theo điểm giảm dần -->
                <h2>2. Danh sách sinh viên sắp xếp theo điểm (Giảm dần)</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ tên</th>
                        <th>Điểm</th>
                    </tr>
                    <xsl:for-each select="school/student">
                        <xsl:sort select="grade" data-type="number" order="descending"/>
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="grade"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 3. Danh sách sinh viên sinh tháng gần nhau -->
                <h2>3. Danh sách sinh viên theo tháng sinh</h2>
                <table>
                    <tr>
                        <th>STT</th>
                        <th>Họ tên</th>
                        <th>Ngày sinh</th>
                    </tr>
                    <xsl:for-each select="school/student">
                        <xsl:sort select="substring(date, 6, 2)" data-type="number" order="ascending"/>
                        <tr>
                            <td><xsl:number/></td>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="date"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 4. Danh sách khóa học có sinh viên học -->
                <h2>4. Danh sách khóa học có sinh viên học</h2>
                <table>
                    <tr>
                        <th>Mã KH</th>
                        <th>Tên khóa học</th>
                    </tr>
                    <xsl:for-each select="school/course">
                        <xsl:sort select="name"/>
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="name"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 5. DS sinh viên học Hóa học 201 -->
                <h2>5. Sinh viên học khóa “Hóa học 201”</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ tên</th>
                    </tr>
                    <xsl:for-each select="school/enrollment[courseRef='c3']">
                        <xsl:variable name="sid" select="studentRef"/>
                        <tr>
                            <td><xsl:value-of select="$sid"/></td>
                            <td><xsl:value-of select="/school/student[id=$sid]/name"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 6. DS sinh viên sinh năm 1997 -->
                <h2>6. Sinh viên sinh năm 1997</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ tên</th>
                        <th>Ngày sinh</th>
                    </tr>
                    <xsl:for-each select="school/student[starts-with(date, '1997')]">
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="date"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- 7. DS sinh viên họ “Trần” -->
                <h2>7. Sinh viên họ “Trần”</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ tên</th>
                    </tr>
                    <xsl:for-each select="school/student[starts-with(name, 'Trần')]">
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="name"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template riêng cho student -->
    <xsl:template match="student">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
