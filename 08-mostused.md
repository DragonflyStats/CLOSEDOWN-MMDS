
08-`mostused`
=================

- This function provides a matrix of reference observations that are used most often as sources of imputation and acolumn of the counts. 
- The observations are listed in sorted order, most often used first.



```R
install.packages("yaImpute")
library(yaImpute)

suppressWarnings(library(dplyr))
suppressWarnings(library(magrittr))
```

    Installing package into '/home/nbcommon/R'
    (as 'lib' is unspecified)
    
    Attaching package: 'dplyr'
    
    The following object is masked from 'package:yaImpute':
    
        vars
    
    The following objects are masked from 'package:stats':
    
        filter, lag
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, setequal, union
    



```R
data(iris)
# form some test data
refs=sample(rownames(iris),50)

```


```R
x <- iris[,1:3] # Sepal.Length Sepal.Width Petal.Length


```


```R
y <- iris[refs,4:5] # Petal.Width Species
# build a yai object using mahalanobis
```


```R
mal <- yai(x=x,y=y,method="mahalanobis")

```


```R
mostused(mal,kth=1) %>% head(10)
```


<dl class="dl-horizontal">
	<dt>142</dt>
		<dd>11</dd>
	<dt>130</dt>
		<dd>8</dd>
	<dt>121</dt>
		<dd>6</dd>
	<dt>122</dt>
		<dd>6</dd>
	<dt>141</dt>
		<dd>6</dd>
	<dt>40</dt>
		<dd>6</dd>
	<dt>11</dt>
		<dd>5</dd>
	<dt>112</dt>
		<dd>5</dd>
	<dt>138</dt>
		<dd>5</dd>
	<dt>38</dt>
		<dd>5</dd>
</dl>


