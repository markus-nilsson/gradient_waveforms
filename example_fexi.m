

% Build gradient waveforms
clear gwfs;
tm = linspace(10e-3, 80e-3, 5);
for c = 1:5
    gwfs{c} = gwf_dde_tm(1e-5, ...
        100e-3, 10e-3, 1e-3, 20e-3, 8e-3, tm(c), 1e9, 1.5e9);
end

% Build a collection of waveforms
my_waveforms = gwf_collection('fexi', gwfs);

% Get the xps
xps = my_waveforms.get_xps();