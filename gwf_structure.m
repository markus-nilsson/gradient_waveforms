classdef gwf_structure

    % This class holds information about a single gradient waveform
    %
    % SI-units applies throughout
    %

    methods (Abstract)
        [gwf, rf, dt] = get_gwf(obj)
    end
        

    methods

        % Obtain the xps 
        function xps = get_xps(obj)
            [gwf, rf, dt] = obj.get_gwf();
            xps = gwf_to_pars(gwf, rf, dt);
        end

    end

end


