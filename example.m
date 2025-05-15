

% Build gradient waveforms
clear gwfs;
g_max = linspace(0, 80e-3, 5);
for c = 1:5


    gwf = zeros(3, 100);
    gwf(1, 1:10) = g_max(c);
    gwf(1, 91:100) = g_max(c);
    gwf = gwf'; 

    dt = 1e-3;

    rf =  zeros(1, 100);
    rf(1:50) = 1;
    rf(51:end) = -1;

    gwfs{c} = gwf_from_gwf_rf_dt(gwf, rf, dt);
end

% Build a collection of waveforms
my_waveforms = gwf_collection('pgse experiment', gwfs);

% Get the xps
xps = my_waveforms.get_xps();