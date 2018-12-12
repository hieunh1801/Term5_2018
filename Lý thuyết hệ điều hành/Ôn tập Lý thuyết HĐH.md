# Lý Thuyết
## Câu 1: Ý nghĩa của System Call. Phần mềm sử dụng khai thác phần cứng như thế nào?
- __Ý nghĩa:__ Để tạo môi trường giao tiếp giữa chương trình và hệ điều hành, hệ điều hành đưa ra những lời gọi hệ thống - System Call. Chương trình dùng các lời gọi hệ thống để giao tiếp và yêu cầu các dịch vụ từ hệ điều hành.
- Truyền tham số qua System Call:
    + __Cách 1:__ Truyền tham số trực tiếp trong thanh ghi
    + __Cách 2:__ Các tham số được lưu trữ dưới dạng bảng hoặc khối
- __Khai thác:__ Phần mềm khai thác phần cứng thông qua hệ điều hành. Nghĩa là phần mềm không trực tiếp khai thác phần cứng mà thông qua trung gian là hệ điều hành. Hệ điều hành quản lý và phân phối tài nguyên(phần cứng) để cho phần mềm sử dụng. Vì vậy mà khi viết phần mềm, ta chỉ quan tâm tới việc vận hành của phần mềm mà không quan tâm nó lưu ở thanh ram nào, ô nhớ bao nhiêu trên phần cứng
## Câu 3: Nêu định nghĩa hệ điều hành. Hệ điều hành có chức năng gì?
- Định nghĩa
- Hệ điều hành là một chương trình quản lý phần cứng máy tính
