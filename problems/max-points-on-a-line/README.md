# Leetcode: Max Points on a Line     :BLOG:Hard:


---

Given n points on a 2D plane, find the maximum number of points that lie on the same straight line.  

---

Similar Problems:  
-   [Largest Triangle Area](https://code.dennyzhang.com/largest-triangle-area)
-   [Water and Jug Problem](https://code.dennyzhang.com/water-and-jug-problem)
-   [Review: Math Problems](https://code.dennyzhang.com/review-math)
-   [Review: gcd Problems](https://code.dennyzhang.com/review-gcd)
-   Tag: [#math](https://code.dennyzhang.com/tag/math), [#gcd](https://code.dennyzhang.com/tag/gcd), [#inspiring](https://code.dennyzhang.com/tag/inspiring)

---

Given n points on a 2D plane, find the maximum number of points that lie on the same straight line.  

Github: [challenges-leetcode-interesting](https://github.com/DennyZhang/challenges-leetcode-interesting/tree/master/max-points-on-a-line)  

Credits To: [leetcode.com](https://leetcode.com/problems/max-points-on-a-line/description/)  

Leave me comments, if you have better ways to solve.  

---

    // Blog link: https://code.dennyzhang.com/max-points-on-a-line
    // Basic Ideas: hashmap
    // For each point check with others:
    //   - Same point
    //   - Vertical line
    //   - Normal line: y=ax+b. We use (a, b) as key for the set
    //
    // Corner cases:
    //  - Empty points
    //  - One point
    //  - All same points
    //  - k is float: 
    //    [[0,0],[94911151,94911150],[94911152,94911151]]
    //
    // Complexity: Time O(n*n), Space O(1)
    /**
     * Definition for a point.
     * type Point struct {
     *     X int
     *     Y int
     * }
     */
    func gcd(x int, y int) int {
        if x == 0 { return y }
        for y!=0 {
            x, y = y, x%y
        }
        return x
    }
    
    func maxPoints(points []Point) int {
        if len(points) <= 1 { return len(points) }
        res := 0
        for i, point1 := range points {
            count := 1
            k_map := map[string]int{}
            // no need to loop all nodes
            for j:=i+1; j<len(points); j++{
                point2 := points[j]
                if point1.X == point2.X && point1.Y == point2.Y {
                    // same point
                    count++
                    continue
                }
                if point1.X == point2.X {
                    // vertical line
                    k_map["INF"] += 1
                } else {
                    // a x1+b = y1
                    // a x2+b = y2
                    // How to get a. a=(y2-y1)/(x2-x1)
                    diffY, diffX := point2.Y-point1.Y, point2.X-point1.X
                    g := gcd(diffX, diffY)
                    a, b := diffX/g, diffY/g
                    // fmt.Println("diffX", diffX, "a", a, "diffY", diffY, b, "g", g)
                    k_index := fmt.Sprintf("%d-%d", a, b)
                    k_map[k_index] += 1
                }
            }
            // fmt.Println(i, k_map)
            if len(k_map) == 0 {
                if count>res { res = count }
            } else {
                for key := range k_map {
                    if k_map[key]+count>res { res = k_map[key]+count }
                }
            }
        }
        return res
    }