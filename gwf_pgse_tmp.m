classdef gwf_pgse_tmp < gwf_from_gwf_rf_dt

    % generate_PGSE_wf
    % Constructs the gradient waveform g(t) and RF modulation rf(t), such that the effective gradient is rf(t) .* g(t)
    % This is for a PGSE sequence

    properties
        Delta_actual 
        delta_actual 
        ramp_actual 
        TE_actual 
        gap180_actual 

        params;

    end

    methods

        % Constructor
        function obj = gwf_pgse_tmp(params) %dt, TE, delta, ramp, Delta, gap180, b)


            dt       = params.dt.value;
            TE       = params.TE.value;
            delta    = params.delta.value;
            ramp     = params.ramp.value;
            Delta    = params.Delta.value;
            gap180   = params.gap180.value;
            b        = params.b.value;


            % 
            [Delta_min, Delta_max] = gwf_pgse.range_Delta_PGSE(TE, delta, ramp, gap180);

            if Delta < Delta_min || Delta > Delta_max
                error('Infeasible: Delta = %.3f ms is outside [%.3f, %.3f] ms', ...
                    Delta*1e3, Delta_min*1e3, Delta_max*1e3);
            end

            N_ramp = round(ramp / dt);
            N_flat = round(delta / dt);
            lobe = [linspace(0,1,N_ramp)'; ones(N_flat,1); linspace(1,0,N_ramp)'];
            N_lobe = length(lobe);

            N_total = round(TE / dt);
            N_gap = round(gap180 / dt);
            N_Delta = round(Delta / dt);

            center = floor(N_total / 2);

            t1_end = center - floor(N_Delta / 2);
            t1_start = t1_end - N_lobe + 1;

            t2_start = center + ceil(N_Delta / 2);
            t2_end = t2_start + N_lobe - 1;

            if t1_start < 1 || t2_end > N_total
                error('Infeasible timing: pulses exceed TE duration. Adjust TE, delta, or ramp.');
            end

            % True waveform
            g = zeros(N_total, 3);
            g(t1_start:t1_end) = lobe;
            g(t2_start:t2_end) = lobe;

            % RF modulation
            rf = ones(N_total, 1);
            rf(center+1:end) = -1;

            % Store
            obj = obj@gwf_from_gwf_rf_dt(g, rf, dt);

            % Scale b
            obj = obj.scale_to_b(b);

            % Actual timing parameters
            obj.Delta_actual = N_Delta * dt;
            obj.delta_actual = N_flat * dt;
            obj.ramp_actual = N_ramp * dt;
            obj.TE_actual = N_total * dt;
            obj.gap180_actual = N_gap * dt;
            obj.params = params;

        end



    end


    methods (Static)

        function [Delta_min, Delta_max] = range_Delta_PGSE(TE, delta, ramp, gap180)

            T_lobe = 2 * ramp + delta;

            Delta_min = T_lobe;
            Delta_max = TE - 2 * T_lobe - gap180;

            if Delta_max < Delta_min
                error('No feasible Delta: decrease ramp/delta or increase TE.');
            end
        end


        function x = make_params(params)

            arguments
                params.dt double = 0.1e-3
                params.TE double = 100e-3
                params.delta double = 5e-3
                params.ramp double = 0.5e-3
                params.Delta double = 20e-3
                params.gap180 double = 8e-3
                params.b double = 1e9
            end

            x.dt       = seq_param(1e-7, 1e-3, unit.s, params.dt);
            x.TE       = seq_param(1e-3, 300e-3, unit.s, params.TE);
            x.delta    = seq_param(0, 50e-3, unit.s, params.delta);
            x.ramp     = seq_param(0, 10e-3, unit.s, params.ramp);
            x.Delta    = seq_param(0, 100e-3, unit.s, params.Delta);
            x.gap180   = seq_param(0, 100e-3, unit.s, params.gap180);
            x.b        = seq_param(0, 100e9, unit.s_per_m2, params.b);
              
            1;
        end
    end



end
