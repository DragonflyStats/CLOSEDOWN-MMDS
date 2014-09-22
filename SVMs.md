 http://stackoverflow.com/questions/6160495/support-vector-machines-a-simple-explanation
 
 So, i'm trying to understand how the SVM algorithm works but i just cannot figure out how you transform some datasets in points of n-dimensional plane that would have a mathematical meaning in order to separate the points through a hyperplane and clasify them.

There's an example here, they are trying to clasify pictures of tigers and elephants, they say "We digitize them into 100x100 pixel images, so we have x in n-dimensional plane, where n=10,000", but my question is how do they transform the matrices that actually represent just some color codes IN points that have a methematical meaning in order to clasify them in 2 categories?

Probably someone can explain me this in a 2D example because any graphical representation i see it's just 2D, not nD.



The short answer is: they don't transform the matrices, but treat each element in the matrix as a dimension (in machine learning each element would be called a Feature). Thus, they need classify elements with 100x100 = 10000 features each. In the linear SVM case, they do so using a hyperplane, which divides the 10,000-dimensional space into two distinct regions.

A longer answer would be: Consider your 2D case. Now, you want to separate a set of two-dimensional elements. This means that each element in your set can be described mathematically as a 2-tuple, namely: e = (x1, x2). For example, in your figure, some full dots might be: {(1,3), (2,4)}, and some hollow ones might be {(4,2), (5,1)}. Note that in order to classify them with a linear classifier, you need a 2-dimensional linear classifier, which would yield a decision rule which might look like this:
 •e = (x1, x2)
 •if (w1 * x1 + w2 * x2) > C : decide that e is a full dot.
 •otherwise : e is hollow.
 
Note that the classifier is linear, as it is a linear combination of the elements of e. The 'w's are called 'weights', and 'C' is the decision threshold. a linear function with 2-elements as above is simply a line, that's why in your figures the H's are lines. 

Now, back to our n-dimensional case, you can probably figure our that a line will not do the trick. In the 3D case, we would need a plane: (w1 * x1 + w2 * x2 + w2 * x3) > C, and in the n-dimensional case, we would need a hyperplane: (w1 * x1 + w2 * x2 + ... + wn * xn) > C, which is damn hard to imagine, none the less to draw :-).



www.cise.ufl.edu/class/cis4930sp11dtm/notes/intro_svm_new.pdf

bytesizebio.net/2014/02/05/support-vector-machines-explained-well/
