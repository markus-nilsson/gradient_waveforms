classdef gwf_extended_structure < gwf_structure

    properties
        te            % Echo time
        tr            % Repetition time
        label         % 1xN integers, e.g., to separate blocks in DDE
        text          % String to store info
        method_name   % Intended method name
    end

    methods
        function obj = gwf_extended_structure(gwf, rf, dt, te, tr, label, text, method_name)
            
            % Call superclass constructor
            obj@gwf_structure(gwf, rf, dt);

            % Assign extended properties
            obj.te = te;
            obj.tr = tr;
            obj.label = label;
            obj.text = text;
            obj.method_name = method_name;
        end
    end

end