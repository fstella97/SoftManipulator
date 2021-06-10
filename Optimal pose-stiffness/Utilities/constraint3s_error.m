function Dx=constraint3s_error(x)
global goal
x1=x(1);
x2=x(2);
x3=0.21;
x4=x(3);
x5=x(4);
x6=0.21;
x7=x(5);
x8=x(6);
x9=0.21;
Dx(1)=-goal(1)+(x9*sin(x7)*(cos(x2)*cos(x4)*sin(x1) + cos(x5)*sin(x4)*((cos(x1) - 1)*cos(x2)^2 + 1) + cos(x2)*sin(x2)*sin(x4)*sin(x5)*(cos(x1) - 1)))/x7 - (x3*cos(x2)*(cos(x1) - 1))/x1 - (x9*cos(x8)*(cos(x7) - 1)*(((cos(x1) - 1)*cos(x2)^2 + 1)*((cos(x4) - 1)*cos(x5)^2 + 1) - cos(x2)*cos(x5)*sin(x1)*sin(x4) + cos(x2)*cos(x5)*sin(x2)*sin(x5)*(cos(x1) - 1)*(cos(x4) - 1)))/x7 + (x6*cos(x2)*sin(x1)*sin(x4))/x4 - (x9*sin(x8)*(cos(x7) - 1)*(cos(x5)*sin(x5)*((cos(x1) - 1)*cos(x2)^2 + 1)*(cos(x4) - 1) + cos(x2)*sin(x2)*(cos(x1) - 1)*((cos(x4) - 1)*sin(x5)^2 + 1) - cos(x2)*sin(x1)*sin(x4)*sin(x5)))/x7 - (x6*cos(x5)*((cos(x1) - 1)*cos(x2)^2 + 1)*(cos(x4) - 1))/x4 - (x6*cos(x2)*sin(x2)*sin(x5)*(cos(x1) - 1)*(cos(x4) - 1))/x4;
Dx(2)=-goal(2)+(x9*sin(x7)*(cos(x4)*sin(x1)*sin(x2) + sin(x4)*sin(x5)*((cos(x1) - 1)*sin(x2)^2 + 1) + cos(x2)*cos(x5)*sin(x2)*sin(x4)*(cos(x1) - 1)))/x7 - (x3*sin(x2)*(cos(x1) - 1))/x1 - (x6*sin(x5)*(cos(x4) - 1)*((cos(x1) - 1)*sin(x2)^2 + 1))/x4 - (x9*cos(x8)*(cos(x7) - 1)*(cos(x2)*sin(x2)*((cos(x4) - 1)*cos(x5)^2 + 1)*(cos(x1) - 1) + cos(x5)*sin(x5)*(cos(x4) - 1)*((cos(x1) - 1)*sin(x2)^2 + 1) - cos(x5)*sin(x1)*sin(x2)*sin(x4)))/x7 + (x6*sin(x1)*sin(x2)*sin(x4))/x4 - (x9*sin(x8)*(cos(x7) - 1)*(((cos(x1) - 1)*sin(x2)^2 + 1)*((cos(x4) - 1)*sin(x5)^2 + 1) - sin(x1)*sin(x2)*sin(x4)*sin(x5) + cos(x2)*cos(x5)*sin(x2)*sin(x5)*(cos(x1) - 1)*(cos(x4) - 1)))/x7 - (x6*cos(x2)*cos(x5)*sin(x2)*(cos(x1) - 1)*(cos(x4) - 1))/x4;
Dx(3)=-goal(3)+(x3*sin(x1))/x1 - (x9*sin(x7)*(sin(x1)*sin(x2)*sin(x4)*sin(x5) - cos(x1)*cos(x4) + cos(x2)*cos(x5)*sin(x1)*sin(x4)))/x7 + (x6*cos(x1)*sin(x4))/x4 + (x9*cos(x8)*(cos(x7) - 1)*(cos(x1)*cos(x5)*sin(x4) + cos(x2)*sin(x1)*((cos(x4) - 1)*cos(x5)^2 + 1) + cos(x5)*sin(x1)*sin(x2)*sin(x5)*(cos(x4) - 1)))/x7 + (x9*sin(x8)*(cos(x7) - 1)*(cos(x1)*sin(x4)*sin(x5) + sin(x1)*sin(x2)*((cos(x4) - 1)*sin(x5)^2 + 1) + cos(x2)*cos(x5)*sin(x1)*sin(x5)*(cos(x4) - 1)))/x7 + (x6*cos(x2)*cos(x5)*sin(x1)*(cos(x4) - 1))/x4 + (x6*sin(x1)*sin(x2)*sin(x5)*(cos(x4) - 1))/x4;
end

