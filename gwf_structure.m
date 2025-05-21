classdef gwf_structure

    % This class holds information about a single gradient waveform
    %
    % SI-units applies throughout

    methods (Abstract)
        [gwf, rf, dt] = get_gwf(obj)
        rf = get_rf(obj)
        dt = get_dt(obj)
        scale_to_b(obj, b_target)
    end
        

    methods

        % Obtain the xps 
        function xps = get_xps(obj)
            xps = gwf_to_pars(obj.get_gwf(), obj.get_rf(), obj.get_dt());
        end

        % Get the q-vector
        function q = get_q(obj)
            q = gwf_to_q(obj.get_gwf(), obj.get_rf(), obj.get_dt());
        end

        % Compute the b-value
        function b = get_b(obj)
            q = obj.get_q();
            bt = q' * q * obj.get_dt();
            b = trace(bt);
        end

        % Calculate the duration
        function T = get_duration(obj)
            gwf = obj.get_gwf();
            T = size(gwf, 1) * obj.get_dt();
        end

        % Enable plotting
        function plot(obj)
            gwf_plot_all(obj.get_gwf(), obj.get_rf(), obj.get_dt());
        end

        function obj = plus(a,b)
            if (isa(b, 'gwf_addon'))
                obj = gwf_superimposed(a,b);
            else
                error('undefined');
            end
        end

        


    end

end


