EA = 6000

Node = [0 0; 3 0; 1.5 2]

elcon = [1 2 EA; 1 3 EA; 2 3 EA]

UBC = [1 1 0; 1 2 0; 2 2 0]

FBC = [2 1 0; 3 1 30; 3 2 -40]

numnode = size(Node,1)

numel = size(elcon,1)

Kg = zeros(2*numnode)

Fg = zeros(2*numnode,1)

Ug = zeros(2*numnode,1)



for el=1:numel

    n1 = elcon(el,1)

    n2 = elcon(el,2)

    x1 = Node(n1,1)

    y1 = Node(n1,2)
  
    x2 = Node(n2,1)

    y2 = Node(n2,1)

    theta = atan2(y2-y1,x2-x1)

    L = sqrt((x2-x1)^2 + (y2-y1)^2)

    C = cos(theta)

    S = sin(theta)



    kel = (EA/L)*[C^2 C*S -C*2 -C*S; C*S S^2 -C*S -S^2; -C^2 -C*S C^2 C*S; -C*S -S^2 C*S S^2]



    k1 = 2*n1-1; 

    k2 = 2*n1;

    k3 = 2*n2-1;

    k4 = 2*n2;



    Kg(k1:k2, k1:k2) = Kg(k1:k2,k1:k2) +kel(1:2,1:2);

    Kg(k1:k2, k3:k4) = Kg(k1:k2,k3:k3) +kel(1:2,3:4);

    Kg(k3:k4, k1:k2) = Kg(k3:k4,k1:k2) +kel(3:4,1:2);

    Kg(k3:k4, k3:k4) = Kg(k3:k4,k3:k4) +kel(3:4,3:4);



end

Kg



k = [Kg(3,3) Kg(3,5:6);Kg(5:6,3) Kg(5:6,5:6)]

f = [0;30;-40]

u = k\f

Ug = [0;0;u(1);0;u(2:3)]

Fg = Kg*Ug



u1 = [Ug(1);Ug(2);Ug(3);Ug(4)]

u2 = [Ug(1);Ug(2);Ug(5);Ug(6)]

u3 = [Ug(3);Ug(4);Ug(5);Ug(6)]



%stress in each element is yet to be find




