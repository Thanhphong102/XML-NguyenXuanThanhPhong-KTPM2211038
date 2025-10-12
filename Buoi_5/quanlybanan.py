from lxml import etree

# Đọc file XML
tree = etree.parse("quanlybanan.xml")
root = tree.getroot()

# 1. Lấy tất cả bàn
print("1. Lấy tất cả bàn:")
for tenban in root.xpath("/QUANLY/BANS/BAN/TENBAN/text()"):
    print(tenban)

# 2. Lấy tất cả nhân viên
print("\n2. Lấy tất cả nhân viên:")
for tennv in root.xpath("/QUANLY/NHANVIENS/NHANVIEN/TENV/text()"):
    print(tennv)

# 3. Lấy tất cả tên món
print("\n3. Lấy tất cả tên món:")
for tenmon in root.xpath("/QUANLY/MONS/MON/TENMON/text()"):
    print(tenmon)

# 4. Lấy tên nhân viên có mã NV02
print("\n4. Lấy tên nhân viên có mã NV02:")
print(root.xpath("/QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']/TENV/text()")[0])

# 5. Lấy tên và số điện thoại của nhân viên NV03
print("\n5. Lấy tên và số điện thoại của nhân viên NV03:")
ten = root.xpath("/QUANLY/NHANVIENS/NHANVIEN[MANV='NV03']/TENV/text()")[0]
sdt = root.xpath("/QUANLY/NHANVIENS/NHANVIEN[MANV='NV03']/SDT/text()")[0]
print(f"Tên: {ten}, SĐT: {sdt}")


# 6. Lấy tên món có giá > 50,000
print("\n6. Lấy tên món có giá > 50,000:")
for tenmon in root.xpath("/QUANLY/MONS/MON[GIA > 50000]/TENMON/text()"):
    print(tenmon)

# 7. Lấy số bàn của hóa đơn HD03
print("\n7. Lấy số bàn của hóa đơn HD03:")
print(root.xpath("/QUANLY/HOADONS/HOADON[SOHD='HD03']/SOBAN/text()")[0])

# 8. Lấy tên món có mã M02
print("\n8. Lấy tên món có mã M02:")
print(root.xpath("/QUANLY/MONS/MON[MAMON='M02']/TENMON/text()")[0])

# 9. Lấy ngày lập của hóa đơn HD03
print("\n9. Lấy ngày lập của hóa đơn HD03:")
print(root.xpath("/QUANLY/HOADONS/HOADON[SOHD='HD03']/NGAYLAP/text()")[0])

# 10. Lấy tất cả mã món trong hóa đơn HD01
print("\n10. Lấy tất cả mã món trong hóa đơn HD01:")
for mamon in root.xpath("/QUANLY/HOADONS/HOADON[SOHD='HD01']/CTHDS/CTHD/MAMON/text()"):
    print(mamon)

# 11. Lấy tên món trong hóa đơn HD01
print("\n11. Lấy tên món trong hóa đơn HD01:")
for tenmon in root.xpath("/QUANLY/MONS/MON[MAMON = /QUANLY/HOADONS/HOADON[SOHD='HD01']/CTHDS/CTHD/MAMON]/TENMON/text()"):
    print(tenmon)

# 12. Lấy tên nhân viên lập hóa đơn HD02
print("\n12. Lấy tên nhân viên lập hóa đơn HD02:")
print(root.xpath("/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOHD='HD02']/MANV]/TENV/text()")[0])

# 13. Đếm số bàn
print("\n13. Đếm số bàn:")
print(root.xpath("count(/QUANLY/BANS/BAN)"))

# 14. Đếm số hóa đơn lập bởi NV01
print("\n14. Đếm số hóa đơn lập bởi NV01:")
print(root.xpath("count(/QUANLY/HOADONS/HOADON[MANV='NV01'])"))

# 15. Lấy tên tất cả món có trong hóa đơn của bàn số 2
print("\n15. Lấy tên tất cả món có trong hóa đơn của bàn số 2:")
for tenmon in root.xpath("/QUANLY/MONS/MON[MAMON = /QUANLY/HOADONS/HOADON[SOBAN=2]/CTHDS/CTHD/MAMON]/TENMON/text()"):
    print(tenmon)

# 16. Lấy tất cả nhân viên từng lập hóa đơn cho bàn số 3
print("\n16. Lấy tất cả nhân viên từng lập hóa đơn cho bàn số 3:")
for tennv in root.xpath("/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOBAN=3]/MANV]/TENV/text()"):
    print(tennv)

# 17. Lấy tất cả hóa đơn mà nhân viên nữ lập
print("\n17. Lấy tất cả hóa đơn mà nhân viên nữ lập:")
for sohd in root.xpath("/QUANLY/HOADONS/HOADON[MANV = /QUANLY/NHANVIENS/NHANVIEN[GIOITINH='Nữ']/MANV]/SOHD/text()"):
    print(sohd)

# 18. Lấy tất cả nhân viên từng phục vụ bàn số 1
print("\n18. Lấy tất cả nhân viên từng phục vụ bàn số 1:")
for tennv in root.xpath("/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOBAN=1]/MANV]/TENV/text()"):
    print(tennv)

# 19. Lấy tất cả món được gọi nhiều hơn 1 lần trong các hóa đơn
print("\n19. Lấy tất cả món được gọi nhiều hơn 1 lần trong các hóa đơn:")
mon_elements = root.xpath("/QUANLY/MONS/MON[MAMON = /QUANLY/HOADONS/HOADON/CTHDS/CTHD[SOLUONG > 1]/MAMON]")

# Dùng set để loại bỏ trùng
tenmon_set = set()
for mon in mon_elements:
    tenmon_set.add(mon.find("TENMON").text)

for tenmon in tenmon_set:
    print(f"{tenmon}")

# 20. Lấy tên bàn + ngày lập hóa đơn tương ứng SOHD='HD02'
print("\n20. Lấy tên bàn + ngày lập hóa đơn tương ứng SOHD='HD02':")
sohd = 'HD02'
soban = root.xpath(f"/QUANLY/HOADONS/HOADON[SOHD='{sohd}']/SOBAN/text()")[0]
tenban = root.xpath(f"/QUANLY/BANS/BAN[SOBAN={soban}]/TENBAN/text()")[0]
ngaylap = root.xpath(f"/QUANLY/HOADONS/HOADON[SOHD='{sohd}']/NGAYLAP/text()")[0]
print(f"{tenban} - Ngày lập: {ngaylap}")
