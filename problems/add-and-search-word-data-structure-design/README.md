# Leetcode: Add and Search Word - Data structure design     :BLOG:Medium:


---

Add and Search Word - Data structure design  

---

Similar Problems:  
-   [Review: Object-Oriented Design Problems](https://code.dennyzhang.com/review-oodesign)
-   [Review: Trie Tree Problems](https://code.dennyzhang.com/review-trie)
-   Tag: [oodesign](https://code.dennyzhang.com/tag/oodesign)

---

Design a data structure that supports the following two operations:  

    void addWord(word)
    bool search(word)

search(word) can search a literal word or a regular expression string containing only letters a-z or .. A . means it can represent any one letter.  

    For example:
    
    addWord("bad")
    addWord("dad")
    addWord("mad")
    search("pad") -> false
    search("bad") -> true
    search(".ad") -> true
    search("b..") -> true

Note:  
You may assume that all words are consist of lowercase letters a-z.  

click to show hint.  

You should be familiar with how a Trie works. If not, please work on this problem: Implement Trie (Prefix Tree) first.  

Github: [challenges-leetcode-interesting](https://github.com/DennyZhang/challenges-leetcode-interesting/tree/master/add-and-search-word-data-structure-design)  

Credits To: [leetcode.com](https://leetcode.com/problems/add-and-search-word-data-structure-design/description/)  

Leave me comments, if you have better ways to solve.  

---

    ## Blog link: https://code.dennyzhang.com/add-and-search-word-data-structure-design
    ## Basic Ideas: Trie tree. Search with dfs or backtracking
    ##              TrieNode: children
    ##     search doesn't necessarily means startswith
    ##     If add you "word" and "words", then ask you whether "word" exists. You should say True
    ## Complexity: Time O(n), Space O(n), n how many nodes in the Trie Tree
    
    class TrieNode(object):
        def __init__(self):
            self.children = collections.defaultdict(TrieNode)
            self.is_word = False
    
    class WordDictionary(object):
    
        def __init__(self):
            """
            Initialize your data structure here.
            """
            self.root = TrieNode()
    
        def addWord(self, word):
            """
            Adds a word into the data structure.
            :type word: str
            :rtype: void
            """
            node = self.root
            for ch in word:
                node = node.children[ch]
            node.is_word = True
    
        def search(self, word):
            """
            Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter.
            :type word: str
            :rtype: bool
            """
            return self.mysearch(word, self.root)
    
        def mysearch(self, word, node):
            if len(word) == 0:
                # if node.is_word is False, we get a prefix, instead of a match.
                return node.is_word is True
    
            ch = word[0]
            if ch != '.':
                if ch not in node.children:
                    return False
                return self.mysearch(word[1:], node.children[ch])
            else:
                for child in node.children.values():
                    if self.mysearch(word[1:], child) is True:
                        return True
                return False
    
    # Your WordDictionary object will be instantiated and called as such:
    # obj = WordDictionary()
    # obj.addWord(word)
    # param_2 = obj.search(word)