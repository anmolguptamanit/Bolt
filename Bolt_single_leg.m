% Defining link lengths.
% Every length unit scales to 5

l1 = 4;
l2 = 3;

% We will define the trajectory of the end point of the leg as an ellipse.
% Defining trajectory Parameters 
a = 1;
b = 0.5;
P4 = [0, -5.3];

% Defining axis
axis(gca, 'equal');
axis([-10 10 -10 10]);
grid on;

% Defining fixed hip coordinates
P1 = [0, 0];

cut = 0.1;

% Main loop
for i = 1:1000
    
    P4 = [0, -5.3];
    P1 = [0, 0];
    
    % Solving for an arbitrary point on the ellipse. We know the
    % equation of ellipse centred at (w, t) is (x-w)^2/a^2 + (y-t)^2/b^2=1
    x_el = cos(cut * i) * a;
    y_el = sin(cut * i) *b + P4(2);
    
    % Since the y_end point cannot go further than -5.3, therefore we apply
    % condition on it.
    if(y_el < -5.3)
        y_el = -5.3;
    end
    
    P3 = [x_el y_el];
    
    % Defining marker for the trajectory
    marker = viscircles(P3, 0.05);
    
    
    
    % Defining the angles theta1 and theta2 for the joint angles
    syms theta1;
    syms theta2;
    
    % Formulating algorithm to find the values of theta1 and theta2
    
    
    if(atan(y_el/x_el)>0)
        alpha = atan(y_el/x_el)-pi;
    else                    
        alpha = atan(y_el/x_el);
    end
   
    
    
    % Using cos rule to find the angles
    theta1 = cos_rule(l2,l1,sqrt(x_el^2+y_el^2))+alpha;
    theta2 = -pi+cos_rule(sqrt(x_el^2+y_el^2),l1,l2);
 
    
    % Defining coordinates of end point of the leg.
    x_end = l1*cos(theta1) + l2*cos(theta1 + theta2);
    y_end = l1*sin(theta1) + l2*sin(theta1 + theta2);
    
    P4= [x_end, y_end];
   
   
    
    % Defining coordinates of knee
    P2 = [l1*cos(theta1) , l1*sin(theta1)];
    

    line2 = line([P1(1) P2(1)],[P1(2) P2(2)]);
    line4 = line([P4(1) P2(1)],[P4(2) P2(2)]);
    

    
    pause(0.001);
    
    
    delete(line2);
    delete(line4);
    
end
    