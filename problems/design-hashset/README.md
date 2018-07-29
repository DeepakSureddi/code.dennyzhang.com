
# Leetcode: Design HashSet     :BLOG:Basic:

---

Design HashSet  

---

Similar Problems:  

-   [Leetcode: Design HashMap](https://code.dennyzhang.com/design-hashmap)
-   Tag: [#oodesign](https://code.dennyzhang.com/tag/oodesign)

---

Design a HashSet without using any built-in hash table libraries.  

To be specific, your design should include these functions:  

-   add(value): Insert a value into the HashSet.
-   contains(value) : Return whether the value exists in the HashSet or not.
-   remove(value): Remove a value in the HashSet. If the value does not exist in the HashSet, do nothing.

Example:  

    MyHashSet hashSet = new MyHashSet();
    hashSet.add(1);         
    hashSet.add(2);         
    hashSet.contains(1);    // returns true
    hashSet.contains(3);    // returns false (not found)
    hashSet.add(2);          
    hashSet.contains(2);    // returns true
    hashSet.remove(2);          
    hashSet.contains(2);    // returns false (already removed)

Note:  

-   All values will be in the range of [0, 1000000].
-   The number of operations will be in the range of [1, 10000].
-   Please do not use the built-in HashSet library.

Github: [challenges-leetcode-interesting](https://github.com/DennyZhang/challenges-leetcode-interesting/tree/master/design-hashset)  

Credits To: [leetcode.com](https://leetcode.com/problems/design-hashset/description/)  

Leave me comments, if you have better ways to solve.  

---

-   Solution:

    // Blog link: https://code.dennyzhang.com/design-hashset
    // Basic Ideas:
    // Use an array of 1000000 item
    // Complexity: Time O(1), Space O(1)
    type MyHashSet struct {
        l []bool
    }
    
    
    /** Initialize your data structure here. */
    func Constructor() MyHashSet {
        m := MyHashSet{}
        m.l = make([]bool, 1000001)
        return m
    }
    
    
    func (this *MyHashSet) Add(key int)  {
        this.l[key] = true
    }
    
    
    func (this *MyHashSet) Remove(key int)  {
        this.l[key] = false
    }
    
    
    /** Returns true if this set contains the specified element */
    func (this *MyHashSet) Contains(key int) bool {
        return this.l[key]
    }
    
    
    /**
     * Your MyHashSet object will be instantiated and called as such:
     * obj := Constructor();
     * obj.Add(key);
     * obj.Remove(key);
     * param_3 := obj.Contains(key);
     */
