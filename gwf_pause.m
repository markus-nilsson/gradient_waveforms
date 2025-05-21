classdef gwf_pause < gwf_from_gwf_rf_dt

    % generate a pause 

    properties
    end

    methods

        % Constructor
        function obj = gwf_pause(dt, T)
            n_tm = round(T / dt);
            gwf = zeros(n_tm, 3);
            rf = zeros(n_tm, 1);

            obj = obj@gwf_from_gwf_rf_dt(gwf, rf, dt);
        end
    end

end
