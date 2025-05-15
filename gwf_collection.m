classdef gwf_collection
    % Holds a number of gwf_structure objects

    properties
        gwfs  % Cell array of gwf_structure objects
        name  % Name of the collection
    end

    methods
        function obj = gwf_collection(name, gwfs)
            
            arguments
                name (1,1) string
                gwfs (1,:) cell
            end

            % Check each entry is a gwf_structure (or subclass)
            for i = 1:numel(gwfs)
                if ~isa(gwfs{i}, 'gwf_structure')
                    error('Each element in gwfs must be of class gwf_structure.');
                end
            end

            obj.name = name;
            obj.gwfs = gwfs;
        end

        function gwf = get_gwf(obj, c)
            gwf = obj.gwfs{c};
        end

        function xps = get_xps(obj)
            
            xps = cell(1, numel(obj.gwfs) );
            for c = 1:numel(obj.gwfs)
                xps{c} = obj.gwfs{c}.get_xps();
            end
            xps = mdm_xps_merge(xps);
            
        end
    end
end