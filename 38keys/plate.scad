module
pcb()
{
    import("edge-cuts.dxf");
}

module
whitespace()
{
    polygon(points = [
        [ 122, -0 ],
        [ 122, -55 ],
        [ 127, -55 ],
        [ 127, -72 ],
        [ 146, -72 ],
        [ 146, -0 ],
    ]);
}

stagger = [ -39, -27, -21, -28, -30 ];

module
alphas()
{
    for (j = [0:2])
        for (i = [0:4])
            translate([ (30 + i * 19), (stagger[i] - j * 19), 0 ])
                square([ 14, 14 ], center = true);
}

module
thumbrow()
{
    translate([ 78.4, -85, 0 ]) rotate([ 0, 0, 0 ])
        square([ 14, 14 ], center = true);
    translate([ 100.75, -90.3, 0 ]) rotate([ 0, 0, 333.4 ])
        square([ 14, 14 ], center = true);
    translate([ 118.6, -103.3, 0 ]) rotate([ 0, 0, 313.4 ])
        square([ 14, 14 ], center = true);
    translate([ 130, -123.75, 0 ]) rotate([ 0, 0, 285 ])
        square([ 14, 14 ], center = true);
}

module
screwholes()
{
    translate([39.5, -48.5, 0]) circle(r=1.15, $fn = 30);
    translate([39.5, -67.5, 0]) circle(r=1.15, $fn = 30);
    translate([96.5, -39.5, 0]) circle(r=1.15, $fn = 30);
    translate([96.5, -58.5, 0]) circle(r=1.15, $fn = 30);
    translate([113.5, -91.5, 0]) circle(r=1.15, $fn = 30);
}

module
plate()
{
    difference()
    {
        pcb();
        alphas();
        whitespace();
        thumbrow();
        screwholes();
    }
}

module
bottom()
{
    difference()
    {
        pcb();
        screwholes();
    }
}

// plate();
// translate([100, 0, 0]) bottom();
bottom();