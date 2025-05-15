classdef gwf_from_gwf_rf_dt < gwf_structure

    % This class holds gradient waveforms defined by matrices

    properties
        gwf % 3xN vector with gradient in physical coordinates
        rf  % 1xN vector that if 1, 0, or -1, depending on the magnetization state
        dt  % 1x1 scalar representing the time step
    end

    methods

        % Constructor
        function obj = gwf_from_gwf_rf_dt(gwf, rf, dt)
            arguments
                gwf (:,3) double
                rf (:,1) double
                dt (1,1) double
            end

            obj.gwf = gwf;
            obj.rf = rf;
            obj.dt = dt;
        end

        function [gwf, rf, dt] = get_gwf(obj)
            gwf = obj.gwf;
            rf = obj.rf;
            dt = obj.dt;
        end

    end

end


