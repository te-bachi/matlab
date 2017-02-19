function omega_out = drehstrom_draw(omega_in, d_omega)

    zoom_factor = 5;

    if omega_in >= 2*pi
        omega_in = omega-in - (2*pi);
    end
    
    % Impedanz
    z           = 40 + 1i * 80;
    
    % Spannung
    u           = 20 * exp(1i * omega_in);
    
    plot([0 real(u)], [0 imag(u)], 'Color', 'blue');
    hold on
    
    % Strom
    i           = (u / z);
    plot(zoom_factor * [0 real(i)], zoom_factor * [0 imag(i)], 'Color', 'red');
    
    % Scheinleistung
    s           = u * conj(i);
    plot([0 real(s)], [0 imag(s)], 'Color', [ 255, 128, 0 ] / 255);
    
    p           = abs(u) * abs(i) * cos(angle(u) - angle(i));
    plot([0 real(p)], [0 imag(p)], 'Color', 'yellow');
    
    
    axis([-20 20 -20 20]);
    daspect([1 1 1]);
    grid on;
    grid minor;
    
    a = xlim;
    b = ylim;
    t = sprintf('angle(S) = %6.2f', rad2deg(angle(s)));
    text(a(1) + 1, b(2) - 1, t);
    
    hold off;
    
    omega_out   = mod((omega_in + d_omega), 2*pi);
end
