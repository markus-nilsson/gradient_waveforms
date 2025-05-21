classdef gwf_dpgse_tm_with_crushers < gwf_dde_tm

    % Generate waveform object for DDE with longitudinal storage based on protocol parameters

    methods

        % Constructor
        function obj = gwf_dpgse_tm_with_crushers(dt, TE, delta, ramp, Delta, gap180, tm, b1, b2, ...
                crush_dur, crush_g, crush_ramp)

            obj = obj@gwf_dde_tm(dt, TE, delta, ramp, Delta, gap180, tm, b1, b2);

        end

        function [gwf, rf, dt] = get_gwf(obj)
            [gwf, rf, dt] = get_gwf@gwf_dde_tm(obj);

            1;
        end


        function xps = get_xps(obj)
            xps = get_xps@gwf_structure(obj);

            xps.samo_variable = 1;
        end

    end
end

