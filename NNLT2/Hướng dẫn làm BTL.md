# Tổ chức thư mục
|Tên thư mục|Công dụng|
|:---------|:--------|
|1. GUI: Graphic User Interface|Lưu trữ Form hay giao diện người dùng|
|2. BLL: Bullstet Logic Layer|Xử lý các thao tác mang tính nghiệp vụ, Kiểm tra tính logic trong công việc thực tế|
|3. Classes|Lưu trữ các tiện ích chung</br>EX: Những biến dùng chung|
|4.	DAL (Data Set Layer)|Xử lý công việc liên quan tới dữ liệu|
|5.	Entity |Mỗi entity tương ứng với một table trong CSDL|
|6.	Reports |In ra các bản báo cáo, hóa đơn => để in ra hóa đơn|

# Thiết kế CSDL 
Trong 1 bảng yêu cầu tối thiểu các Procedure sau
|Tên Proceure|Công dụng|
|:----------|:-------|
|1. Insert|Thêm dữ liệu vào một bảng|
|2. Update|Cập nhật|
|3. Delete|Xóa|
|4. Select All|Xem tất cả|

# BTL MẪU - Quản lý danh mục vật tư
__Bước 1__ : Tạo class __Classes/Variable.cs__ :lưu trữ các biến toàn cục dùng chung. </br>VD : tên nhà hàng - sau này khi muốn đổi tên nhà hàng thì ta thay ở trong này => nó sẽ auto cập nhật những thông tin liên quan  </br>
```CSharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace QLVatTu // Xóa .Classes ở đây để có thể dùng toàn chương trình
{
    //Lớp chứa các biến dùng chung cho toàn bộ chương trình

    public static class Variable
    {

        public static string TenMayChu = "BONBUN\\SERVER2012";
        public static string TenCSDL = "QLSV";
        private static string TenUN = "sa";
        private static string PW = "123456";


        private static string TenDonViSudung = "Cửa hàng Hùng Mạnh";
        private static string DiaChi = "236 Hoàng Quốc Việt";
    }
}

```
> Bước 2: 