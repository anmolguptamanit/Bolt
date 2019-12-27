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
P1_1 = [0, 0];
P1_2 = [0, 0];
cut = 0.1;

% Main loop
for i = 1:1000
    
    P4 = [0, -5.3];
    P1 = [0, 0];
    
    % Solving for an arbitrary point on the ellipse. We know the
    % equation of ellipse centred at (w, t) is (x-w)^2/a^2 + (y-t)^2/b^2=1
    x_el_1 = cos(cut * i) * a;
    y_el_1 = sin(cut * i) *b + P4(2);
    
    x_el_2 = cos(cut*(i+30))*1;
    y_el_2 = sin(cut*(i+30)) *b + P4(2);
 
    
    % Since the y_end point cannot go further than -5.3, therefore we apply
    % condition on it.
    if(y_el_1 < -5.3)
        y_el_1 = -5.3;
    end
    if(y_el_2 < -5.3)
        y_el_2 = -5.3;
    end
    
    P3_1 = [x_el_1 y_el_1];
    P3_2 = [x_el_2 y_el_2];
    
    % Defining marker for the trajectory
    marker_1 = viscircles(P3_1, 0.05);
    marker_2 = viscircles(P3_2, 0.05);
    
    
    
    % Defining the angles theta1 and theta2 for the joint angles
    syms theta1_1;
    syms theta2_1;
    syms theta1_2;
    syms theta2_2;
    
    % Formulating algorithm to find the values of theta1 and theta2
    
    
    if(atan(y_el_1/x_el_1)>0)
        alpha_1 = atan(y_el_1/x_el_1)-pi;
    else                    
        alpha_1 = atan(y_el_1/x_el_1);
    end
    
    
    if(atan(y_el_2/x_el_2)>0)
        alpha_2 = atan(y_el_2/x_el_2)-pi;
    else                    
        alpha_2 = atan(y_el_2/x_el_2);
    end
   
    
    
    % Using cos rule to find the angles
    theta1_1 = cos_rule(l2,l1,sqrt(x_el_1^2+y_el_1^2))+alpha_1;
    theta2_1 = -pi+cos_rule(sqrt(x_el_1^2+y_el_1^2),l1,l2);
    
    theta1_2 = cos_rule(l2,l1,sqrt(x_el_2^2+y_el_2^2))+alpha_2;
    theta2_2 = -pi+cos_rule(sqrt(x_el_2^2+y_el_2^2),l1,l2);
 
    
    % Defining coordinates of end point of the leg.
    x_end_1 = l1*cos(theta1_1) + l2*cos(theta1_1 + theta2_1);
    y_end_1 = l1*sin(theta1_1) + l2*sin(theta1_1 + theta2_1);
    
    x_end_2 = l1*cos(theta1_2) + l2*cos(theta1_2 + theta2_2);
    y_end_2 = l1*sin(theta1_2) + l2*sin(theta1_2 + theta2_2);
    
    P4_1 = [x_end_1, y_end_1];
    P4_2 = [x_end_2, y_end_2];
    
   
   
    
    % Defining coordinates of knee
    P2_1 = [l1*cos(theta1_1) , l1*sin(theta1_1)];
    P2_2 = [l1*cos(theta1_2) , l1*sin(theta1_2)];

    line1 = line([P1_1(1) P2_1(1)],[P1_1(2) P2_1(2)]);
    line2 = line([P4_1(1) P2_1(1)],[P4_1(2) P2_1(2)]);
    
    
    line3 = line([P1_2(1) P2_2(1)],[P1_2(2) P2_2(2)]);
    line4 = line([P4_2(1) P2_2(1)],[P4_2(2) P2_2(2)]);
    

    
    pause(0.001);
    
    delete(line1);
    delete(line2);
    delete(line3);
    delete(line4);
    
end
    