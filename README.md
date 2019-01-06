# Tiêu đề 1
## Tiêu đề 2
### Tiêu đề 3
#### Tiêu đề 4
##### Tiêu đề 5 
###### Tiêu đề 6  

    Tab để tạo một ô vuông

dấu phân cách

---

*** 

*in nghiêng*  or _in nghiêng_.

**bôi đậm** or __bôi đậm__

**_in nghiêng kèm bôi đậm_**

~~Gạch ngang chữ~~

# Danh sách - list
+
-
*
1.
1.
1.
# Liên kết
[Tên link muốn tô đậm](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet "Tiêu đề nếu di chuột vào sẽ hiển thị")

# Hình ảnh

![alt text](./image1.jpg "hoặc chèn link vào trước")

```
Tạo một khối

```

```javascript 
var hieu=12
/// Chỉ định ngôn ngữ JAVASCRIP
```

```c++
const a = 11;
cout<<"This is C++"
// Chỉ định ngôn ngữ C++
```


tô `đậm` chữ


# Kẻ bảng

| Đầu           | Giữa dòng     | cuối  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

> Khối lệnh có bôi đậm ở đầu. Tự động wrap khi xuống dòng. Ghi chú ở đây

<dl>
    <h1>Nhúng được thẻ HTML vào và bọc trong thẻdl<h1>
<a href="http://www.youtube.com/watch?feature=player_embedded&v=YOUTUBE_VIDEO_ID_HERE
" target="_blank"><img src="http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

<dl/>


# ListView PART 1 - Cơ bản - recyclerlistview 

https://medium.com/differential/react-native-basics-how-to-use-the-listview-component-a0ec44cf1fe8

Trong __ListView__ ta quan tâm tới 2 vấn đề chính:

- __Dữ liệu__ được truyền vào ?

 - Nó __hiển thị__ như thế nào ?

Trong bài ta sử dụng __recyclerlistview__ - Thư viện này tăng hiệu suất hơn ListView và FlatList

### Bước 1 - Chuẩn bị dữ liệu
```js
/**
 * Data.js : Dữ liệu mà ta sẽ đẩy vào list
*/

let Data = [
    // Một mảng các đối tượng, mỗi đối tượng tương ứng với một row trong list
    {
        type: "Normal",
        item: {
            
            name: "Nguyen Van An",
            image: "https://upload.wikimedia.org/wikipedia/commons/9/9a/Green_circle.png",
            leastMessage: "Hello this is ",
            timeLeft: "12h22'"
        }
    },
    {
        type: "Normal",
        item: {
            
            name: "Nguyen Van An",
            image: "https://upload.wikimedia.org/wikipedia/commons/9/9a/Green_circle.png",
            leastMessage: "Hello this is ",
            timeLeft: "12h22'"
        }
    }, // And More
]
export default Data; 
    
```

### Bước 2 - Hiển thị từng hàng của list

```js
/**
 * ConservationCard.js
*/
import React, { Component } from 'react';
import { View, Text, Image, StyleSheet, Dimensions, TouchableOpacity } from 'react-native';
const {height, width} = Dimensions.get("screen");

export default class ConservationCard extends Component {
    constructor(props){
        super(props);
       
    }
    render() {
        return (
            <TouchableOpacity style={styles.container}>
                <Image style={styles.image} source={{uri: this.props.data.item.image}} />
                <View style={styles.contentContainer}>
                    <View style={styles.nameContainer}>

                        <Text numberOfLines={1} 
                        ellipsizeMode ={'tail'} 
                        style={styles.txtName}>
                             { 
                                this.props.data.item.name
                             }
                            
                        </Text>

                        <Text style={styles.txtTime}>
                            {
                                this.props.data.item.timeLeft
                            }
                            
                        </Text>
                    </View>
                    <Text numberOfLines={1} // Hiển thị trên một dòng
                    ellipsizeMode ={'tail'} // Nếu qua dòng thì sẽ hiển thị đuôi là ...
                    style={styles.txtMessage}>
                            {
                                this.props.data.item.leastMessage
                            }
                            
                    </Text>
                </View>
                
                    
               
                
            </TouchableOpacity>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        // backgroundColor:"gray",
        height: 70,
        width: width,
        flexDirection: 'row',
        marginTop: 5,
        paddingTop: 10,
        paddingHorizontal: 10,
        backgroundColor: "white"
    },
    contentContainer:{
        flex: 1,
        flexDirection: "column",
        borderBottomColor: "gray",
        borderBottomWidth: 0.2,
    },
    image: {
        height: 55,
        width: 55,
        borderRadius: 55,
        marginHorizontal: 5,
    },
    nameContainer: {
        // backgroundColor: "gray",
        paddingHorizontal: 10,
        flexDirection: "row",
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 5,
    },
    txtName: {
        fontSize: 18,
        fontWeight: 'bold',
        color: "black",
        width: width - 230
    },
    txtTime: {
        fontSize: 14,

    },
    txtMessage: {
        marginTop: 5,
        paddingLeft: 15,
        fontSize: 14
    }
})

```
