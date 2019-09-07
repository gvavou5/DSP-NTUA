function levels = linearQuantizer(s, Bits)
Maxs = ceil(max(max(s)));
Mins = floor(min(min(s)));
comp = max(abs(Mins), abs(Maxs));
Maxs = comp;
Mins = (-1)*comp;
% distance between levels
Lvl_Distance = (Maxs - Mins)/2^Bits;
New_Values = floor((s-Mins)/Lvl_Distance);
Mins = Mins + Lvl_Distance/2;
levels = Mins + Lvl_Distance*New_Values;
