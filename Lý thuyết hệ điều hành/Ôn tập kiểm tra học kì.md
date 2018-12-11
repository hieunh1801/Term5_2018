# Ôn tập kiểm tra học kì
#### Mục lục
```
PART 1: 50 câu lý thuyết

    1. Ý nghĩa của System Call.  Hãy giải thích bình thường các phần mềm ứng dụng “khai thác” phần cứng của máy như thế nào? 

    2. Một tiến trình yêu cầu Hệ điều hành chuyển trạng thái cho nó “ngủ” 5 giây. Hệ điều hành có đảm bảo được là sẽ kích hoạt tiến trình này đúng 5 giây sau đó không? Tại sao? 

    3. Nêu định nghĩa “Hệ điều hành”. Hệ điều hành thực hiện những chức năng chính gì?

    4. Multi-tasking là gì? Giải thích sự khác nhau giữa các hình thức Multi-tasking (cooperative and pre-emtive multi-tasking).

    5. Sự giống nhau và khác nhau giữa Chương trình, Tiến trình và Luồng (Program, Process and Thread).

    6. So sánh ưu và nhược điểm giữa Hệ điều hành client-server và hệ điều hành đơn khối (monolithic) truyền thống. 7. Hãy giải thích cơ chế CPU chuyển từ việc thực hiện process này sang process khác. Làm sao có thể đảm bảo được việc thực hiện đúng các lệnh của process tương ứng? 

    8. Mục đích và nguyên tắc của việc lập lịch cho CPU (Process Scheduling) 

    9. Ý nghĩa căn bản của Lập lịch, Sự khác nhau giữa Lập lịch dài kì và lập lịch ngắn hạn?

    10. Giới thiệu sơ lược 5 cách lựa chọn tiến trình từ “ready to run” để thực hiện. Đánh giá thuật toán FCFS

    11. Giới thiệu sơ lược 5 cách lựa chọn tiến trình từ “ready to run” để thực hiện. Đánh giá thuật toán SJF 

    12. Giới thiệu sơ lược 5 cách lựa chọn tiến trình từ “ready to run” để thực hiện. Đánh giá thuật toán SRF 

    13. Giới thiệu sơ lược 5 cách lựa chọn tiến trình từ “ready to run” để thực hiện. Đánh giá thuật toán RR 

    14. Giải thích tại sao phần địa chỉ cao (top-half) của hệ điều hành không phải là tiến trình (process). Giải thích tại sao phần địa chỉ thấp (bottom-half) của hệ điều hành cũng không phải là tiến trình (process).

    15. Giải thích ngắn gọn trạng thái của các tiến trình, các mô hình tiến trình hệ thống (process models) chung. 

    16. Giải thích vai trò của PCB (process control block).  

    17. Giới thiệu và giải thích ngắn gọn các thành phần (components) của Hệ điều hành.  

    18. Nêu vắn tắt các kĩ thuật cấp phát bộ nhớ (nạp chương trình vào bộ nhớ). 

    19. Trong kỹ thuật cấp phát bộ nhớ phân vùng động, khi nạp tiến trình mới vào bộ nhớ cần lựa chọn một vùng còn “ rỗng” nào đó. Nêu các phương pháp/thuật toán lựa chọn. 20. Phân tích hai khái niệm Page và Paging (trang và phân trang).  

    21. Giải thích cơ chế phân đoạn (segmentation) trong quản lý bộ nhớ của hệ điều hành. 

    22. Mô tả ngắn gọn “Bộ nhớ ảo” – Virtual memory. Bộ nhớ ảo có lợi và thiệt hại gì đối với việc tối ưu hoá sử dụng CPU. 

    23. Trong kỹ thuật bộ nhớ ảo thường sử dụng Phân trang theo yêu cầu (demand paging). Hãy giới thiệu cơ chế này. 

    24. Trong kỹ thuật sử dụng Bộ nhớ ảo Hệ điều hành cần có bộ phận quản lý việc hoán chuyển các trang/đoạn giữa bộ nhớ thực và bộ nhớ ảo và có thể xảy ra “Lỗi trang”  (page fault). Hệ điều hành gải quyết vấn đề đó như thế nào và mục tiêu cần đạt được?

    25. Đánh giá các thuật toán thay trang (Page Replacement) trong kỹ thuật sử dụng Bộ nhớ ảo. 

    26. Nêu ngắn gọn các thuật toán Thay thế trang trong kỹ thuật bộ nhớ ảo, Trình bày và giải thích bằng ví dụ thuật toán FIFO. 27. Nêu ngắn gọn các thuật toán Thay thế trang trong kỹ thuật bộ nhớ ảo, Trình bày và giải thích bằng ví dụ thuật toán Tối ưu OPT. 
    
    28. Nêu ngắn gọn các thuật toán Thay thế trang trong kỹ thuật bộ nhớ ảo, Trình bày và giải thích bằng ví dụ thuật toán LRU. 

    29. Phân biệt hai hiện tượng phân mảnh nội (internal fragmentation) và phân mảnh ngoài (external fragmentation), chúng xuất hiện khi nào và tại sao? 

    30. Giải thích khái niệm “hoán chuyển” (swapping); Ý nghĩa, ứng dựng của việc áp dụng kĩ thuật này.

    31. Hãy giải thích vì sao DMA thường được “ưu ái” sử dụng như là phương thức thực thi trao đổi với ngoại vi? DMA có lợi điểm gì không đối với input thông qua bàn phím? Giải thích tại sao hoặc tại sao không? 

    32. Các máy tính nguyên chiếc sử dụng phổ biến hiện nay thường cài đặt Hệ điều hành Windows XP hoặc Vista; đây là các hệ thống/ Hệ điều hành Đa trình đa nhiệm. Hãy giới thiệu một số dạng hệ thống/ hệ điều hành khác.    
    33. Khi học môn “Tin học đại cương” chúng ta đã được biết đến một cách chia các thiết bị ngoại vi thành 2 hoặc 3 loại (nhóm) là “VÀO’, “RA” và/hoặc vừa “VÀO vừa RA”; Dưới góc nhìn người thiết kế Hệ điều hành chúng ta có thể chia thiết bị ngoại vi thành 2 loại. Đó là gì và cách chia này dựa trên căn cứ nào? Hãy nêu ví dụ một số ngọai vi thuộc từng loại trên.  
    
    34. Giải thích sự khác biệt giữa “polled I/O” và “interrupt-driven I/O”. Nêu những ưu điểm của “interrup-driven I/O” so với “polled I/O”. 
    
    35. Một cách tương đối, ổ đĩa cứng chậm hơn rất nhiều so với CPU. Nêu các yếu tố đánh giá tốc độ truy xuất dữ liệu trên đĩa. Hãy nêu ngắn gọn các kĩ thuật mà Hệ điều hành sử dụng để nâng cao thông lượng (throughput) trung bình của đĩa.  

    36. Hãy giải thích thuật toán Lập lịch cho đầu từ FCFS là gì, cho ví dụ để mô tả để tính được seek time.

    37. Hãy giải thích thuật toán Lập lịch cho đầu từ SSTF là gì, cho ví dụ để mô tả để tính được seek time. 
    
    38. Hãy giải thích thuật toán Lập lịch cho đầu từ SCAN là gì, cho ví dụ để mô tả để tính được seek time. 

    39. Hãy giải thích thuật toán Lập lịch cho đầu từ C-SCAN là gì, cho ví dụ để mô tả để tính được seek time.

    40. Hãy giải thích thuật toán Lập lịch cho đầu từ C-LOOK là gì, cho ví dụ để mô tả để tính được seek time.

    41. Có 2 dạng thiết bị đầu cuối nối tiếp (serial) và memory-mapped đều đẩy kí tự ra màn hình. Hãy giải thích tại sao thiết bị đầu cuối nối tiếp phải sử dụng ngắt trong khi thiết bị đầu cuối memory-mapped không bắt buộc. 

    42. Tắc nghẽn (deadlock)  và các điều kiện để xảy ra tắc nghẽn. 

    43. Nguyên tắc/ phương thức chung để nâng cao hiệu năng của hệ thống. 

    44. Đánh giá ngắn gọn các loại thiết bị lưu trữ; sự khác nhau căn bản giữa Đĩa cứng và Băng từ; Nguyên tắc tổ chức lưu trữ tệp tin trên 2 loại thiết bị lưu trữ này. 

    45. Các thuộc tính chính và các trạng thái của File các hệ điều hành khác nhau thường có? 46. Giới thiệu cấu trúc thư mục trong việc tổ chức lưu trữ tệp tin trên đĩa. 

    47. Các phương pháp được sử dụng để quản lí, cấp phát các block đĩa cho các File. 

    48. Tại sao ta có thể nói “Hệ điều hành thực hiện Vào/Ra”. Hãy giải thích cơ chế Chương trình ứng dụng thực hiện I/O như thế nào? 

    49. Phân biệt Device, Driver và Device Controller. 

    50. Giải thích khái niệm Đoạn găng (Critical Section). Nêu ngắn gọn biện pháp giải pháp điều phối tiến trình qua đoạn găng. 
    
PART 2: 4x4 = 16 câu bài tập
```