
set SAT;                

param pi := acos(-1);

param R;                      
param v_syg;                  

param theta_deg{SAT};         
param phi_deg{SAT};           
param r_sat{SAT};            
param czas{SAT};              

# pseudodystanse liczone w modelu
param d{j in SAT} := v_syg * czas[j];

# zamiana stopni na radiany i konwersja współrzędnych satelitów do kartezjanskich
param theta_rad{j in SAT} := theta_deg[j] * pi / 180;
param phi_rad{j in SAT}   := phi_deg[j] * pi / 180;

param x_sat{j in SAT} := r_sat[j] * cos(theta_rad[j]) * cos(phi_rad[j]);
param y_sat{j in SAT} := r_sat[j] * cos(theta_rad[j]) * sin(phi_rad[j]);
param z_sat{j in SAT} := r_sat[j] * sin(theta_rad[j]);

var x_odb; 
var y_odb;
var z_odb;
var b_zegara;  

# funkcja celu: suma kwadratów różnic (pseudodystanse + bias)
minimize cel :
    sum {j in SAT} ( sqrt( (x_odb - x_sat[j])^2 + (y_odb - y_sat[j])^2 + (z_odb - z_sat[j])^2 )
                     - ( d[j] + v_syg * b_zegara ) )^2 ;

