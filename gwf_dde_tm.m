classdef gwf_dde_tm < gwf_sequence

    % Generate waveform object for DDE with longitudinal storage based on protocol parameters

    properties
        tm_actual;
    end

    methods

        % Constructor
        function obj = gwf_dde_tm(dt, TE, delta, ramp, Delta, gap180, tm, b1, b2)

            % Generate PGSE
            obj = obj@gwf_sequence({... 
                gwf_pgse(dt, TE, delta, ramp, Delta, gap180, b1), ...
                gwf_pause(dt, tm), ...
                gwf_pgse(dt, TE, delta, ramp, Delta, gap180, b2)});

            obj.tm_actual = obj.gwf_structures{2}.get_duration();
        end

        function xps = get_xps(obj)
            xps = get_xps@gwf_structure(obj);

            xps.samo_variable = 1;
        end

    end
end

