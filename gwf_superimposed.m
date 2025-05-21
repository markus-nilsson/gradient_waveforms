classdef gwf_superimposed < gwf_structure

    properties
        a;
        b;
    end

    methods

        function obj = gwf_superimposed(a,b)
            obj.a = a;
            obj.b = b;
        end

        function [gwf,rf,dt] = get_gwf(obj)

            gwf = obj.a.get_gwf() + obj.b.get_gwf(obj.a);

            rf = obj.get_rf();
            dt = obj.get_dt();


        end

        function rf = get_rf(obj)
            rf = obj.a.get_rf();
        end

        function dt = get_dt(obj)
            dt = obj.a.get_dt();
        end

        function obj = scale_to_b(obj, b_target)
            error('not implemented');
        end
        

    end

end