# PistonMotion
Model movement of piston in cylinder against rotation of crankshaft 

For a gudgeon in a cylinder (or possibly in a crosshead) driving (or driven by)
a crankshaft, via a connecting rod, we can calculate the displacement of the 
gudgeon (thus the piston) as a fuction of the crank angle, the stroke and the 
con-rod length.

If we normalise the throw of the crank to 1 (i.e. stroke = 2), we have by cosine rule:

       h^2 = c^2 - 1 + 2h.cos(A)

where *h* = height of gudgeon (above crankshaft centreline); *c* = con-rod length
(relative to throw = 1); *A* = crank angle.

Solving this for the (positive) quadratic root, we get:

       h = @ + sqrt(@^2 + c^2 - 1) 
    
where @ = cos(A). 

Furthermore, we can derive the angle *B* at the big-end of the con-rod between the rod and the crank throw: 

    cos(B) = (c^2 + 1 - h^2) / 2c  

Alternatively, applying the sine rule gives us the angle *G* of the con-rod at the gudgeon off the verticle:

    sin(G) = sin(A) / c

