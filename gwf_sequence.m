classdef gwf_sequence < gwf_structure

    % Stacks a number of gradient waveforms

    properties
        gwf_structures;
    end

    methods

        % Constructor
        function obj = gwf_sequence(gwf_structures)
            obj.gwf_structures = gwf_structures;
        end

        function [gwf, rf, dt] = get_gwf(obj)

            gwf = [];
            for c = 1:numel(obj.gwf_structures)
                gwf = cat(1, gwf, obj.gwf_structures{c}.get_gwf());
            end

            rf = obj.get_rf();
            dt = obj.get_dt();
        end

        function rf = get_rf(obj)

            rf = [];
            for c = 1:numel(obj.gwf_structures)
                rf = cat(1, rf, obj.gwf_structures{c}.get_rf());
            end
        end

        function dt = get_dt(obj)
            dt = obj.gwf_structures{1}.get_dt();

            % xxx: check that all dt's are identical!
        end

        function obj = scale_to_b(b_target)
            error('not implemented yet');
        end

    end
end

