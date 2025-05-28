classdef seq_param

    properties
        min
        max
        value = NaN
        unit
    end

    methods

        function obj = seq_param(min, max, unit, value)

            obj.min = min;
            obj.max = max;
            obj.unit = unit;

            if (nargin > 3)
                obj.value = value;
            end

        end

        function obj = set.value(obj, value)

            if (value > obj.max), error('above range'); end
            if (value < obj.min), error('below range'); end

            obj.value = value;
        end
        % 
        % % print to string
        % function txt = str(obj)
        % 
        %     switch (obj.unit)
        %         case unit.s
        %             sprintf('%1.2f', obj.value)
        %     end
        % 
        % end

    end

    methods (Static)

        function print_params(params)

            f = fieldnames(params);
            for c = 1:numel(f)
                disp(sprintf('%s: %1.2f', f{c}, params.(f{c}).value));
            end

        end

        function range = binary_search(gwf, params, param)

            for c = 1:2

                lo = params.(param).min;
                hi = params.(param).max;

                disp(sprintf('Starting from %1.2f with lo = %1.2f and hi = %1.2f', (lo + hi) / 2, lo, hi));


                tol = 1e-9;
                while abs(hi - lo) > tol

                    mid = (lo + hi) / 2;

                    params.(param).value = mid;

                    try
                        gwf(params);

                        if (c == 2)
                            lo = mid;
                        else
                            hi = mid;
                        end
                    catch
                        if (c == 2)
                            hi = mid;
                        else
                            lo = mid;
                        end
                    end

                end

                range(c) = mid;

                %disp(sprintf('Ending with from %1.2f', params.(param).value));
            end



        end


    end

end