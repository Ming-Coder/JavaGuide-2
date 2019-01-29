[Java集合框架](https://jlj98.top/categories/Java%E9%9B%86%E5%90%88%E6%A1%86%E6%9E%B6/)

## 集合总结

| 集合                                                         | 初始容量                                           | 扩容                                                         | 是否安全             | 结构                 | 集合特性         |
| ------------------------------------------------------------ | -------------------------------------------------- | ------------------------------------------------------------ | -------------------- | -------------------- | ---------------- |
| [Set](https://jlj98.top/2018/09/15/java-set/)                | HashSet底层使用HashMap；TreeSet底层使用的是TreeMap | 和使用的底层相似                                             | N                    | HashMap/TreeMap      | 无序不重复       |
| [Vector](https://jlj98.top/2018/05/08/java-vector/)          | 10                                                 | 当元素超过容量时，如果有初始扩容量，则增加初始扩容量，否则，增加1倍 | Y(synchrozized)      | 数组                 |                  |
| [ArrayList](https://jlj98.top/2018/04/18/Java-ArrayList-LinkedList/#ArrayList%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90) | 10                                                 | 扩容原来的0.5倍，即第一次扩容后的容量是16                    | N                    | 数组                 |                  |
| [LinkedList](https://jlj98.top/2018/04/18/Java-ArrayList-LinkedList/#LinkedList%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90) | 没有                                               |                                                              | N                    | 双向链表             |                  |
| [HashMap](https://jlj98.top/2018/04/24/Java-HashMap/)        | 默认初始容量16，加载因子0.75                       | 当元素个数超过容量长度*加载因子，扩容1倍                     | N                    | 数组+双向链表+红黑树 | 键值对可以为null |
| [ConcurrentHashMap](https://jlj98.top/2018/06/27/Java-ConcurrentHashMap/) | 16，加载因子0.75                                   | 扩充一倍                                                     | Y(synchrozized和CAS) | 数组+双向链表+红黑树 | 键值对不能为null |
| [HashTable](https://jlj98.top/2018/09/19/java-Hashtable/)    | 默认初始容量11，加载因子0.75                       | 默认情况下阀值为8，当超过8就扩容，扩大1倍，且+1              | Y(synchrozized)      | 数组+链表            | 键值对不能为null |

## Map下的HashTable和concurrentMap的区别？

HashTable是Synchronize修饰的，是整个数据上进行加群的，是线程安全的，键值都不能为null。

ConcurrentMap是线程安全的，不能有null键。Java8之前是使用segment来分段管理数据的。Java8之后，虽然保留了segment，重新优化，使用CAS。CAS 操作包含三个操作数 —— 内存位置（V）、预期原值（A）和新值(B)。 如果内存位置的值与预期原值相匹配，那么处理器会自动将该位置值更新为新值 。否则，处理器不做任何操作。无论哪种情况，它都会在 CAS 指令之前返回该 位置的值。（在 CAS 的一些特殊情况下将仅返回 CAS 是否成功，而不提取当前 值。）CAS 有效地说明了“我认为位置 V 应该包含值 A；如果包含该值，则将 B 放到这个位置；否则，不要更改该位置，只告诉我这个位置现在的值即可。”

## LinkedList、ArraryList、Vector、Set的区别

LinkedList底层是链表的。它的get方法，源码上分析，先把要查找的位置对半查找，如果当前index值小于一半

ArraryList和Vector是数组的，前者不是线程安全的，后者是线程安全的。两者的初始容量都是10，前者扩容是1.5，后者默认是2倍。

Map

HashMap是key-value的，底层是数组+链表+红黑树。初始容量是16，每次扩容是之前的2倍。Map是通过计算hash值的，如果发生冲突，则转化成链表，如果链表的冲突值大于8，则转化成红黑色。

## 一个ArrayList在循环过程中删除，会不会出问题，为什么?

ArrayList 的 remove 方法有两种删除，一种是 remove(int index)，另外一种是remove(Object o)。

```java
List<String> list = Stream.of("aa", "aa", "bb", "bb", "cc", "cc", "dd", "dd").collect(Collectors.toList());
        for (int i = 0; i < list.size(); i++) {
            if ("aa".equals(list.get(i))) {
                list.remove(i);
            }
        }
        System.out.println(list);
        for (int i = 0; i < list.size(); i++) {
            if ("bb".equals(list.get(i))) {
                list.remove("bb");
            }
        }
        System.out.println(list);
```

由于源码中删除当前位置，集合大小减一，删除后面的元素向前移动一位。如果相同两个元素在一起，就会导致后面的一个元素不能删除成功。如果使用迭代器Iterator，就不会出现上面的问题。

```java
 for (String obj : list) {
 	if (obj.equals("cc")) {
		list.remove(obj);
 	}
}
```

上面这种for-each写法会报出著名的并发修改异常：java.util.ConcurrentModificationException。

## Map中支持排序 TreeMap 和 LinkedHashMap

- TreeMap：能够把它保存的记录根据key排序，默认是按升序排序，也可以指定排序的比较器，当用Iterator 遍历TreeMap时，得到的记录是排过序的。TreeMap不允许key的值为null。非同步的。
- LinkedHashMap：保存了记录的插入顺序，在用Iterator遍历LinkedHashMap时，先得到的记录肯定是先插入的。在遍历的时候会比HashMap慢。key和value均允许为空，非同步的。