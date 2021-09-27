`timescale 1ns/1ps
// Aca se incluyen todos los modulos
`include "driver_monitor.sv"
`include "if_trans.sv"
// Aca se incluye el DUT "Device Under Test"
`include "Library.sv"

///////////////////////////////////////
// Modulo para correr la prueba
///////////////////////////////////////
module test_bench;
    // Variables/Parametros "globales" de la simulacion
    reg clk;
    parameter bits = 1;
    parameter drvrs = 4;
    parameter pckg_sz = 16; // pckg_sz = {addr,payload}

    // Instancio el test: este modulo va a dar inicio a los demas

    // Instancio la interfaz que interconecta el controlador con las FIFO
    ctrl_if #(
        .bits(bits),
        .drvrs(drvrs),
        .pckg_sz(pckg_sz)
    ) 
    _if ( .clk(clk) );

    always #5 clk = ~clk;   // Sincronizmo

    // Instancio el modulo a testear
    bs_gnrtr_n_rbtr #( 
        // .broadcast() // Mantengo la misma direccion de Broadcast
        .bits(bits),
        .drvrs(drvrs), 
        .pckg_sz(pckg_sz)
    )
    dut
    (   // Conecto los terminales a la interfaz, conectando el DUT con el ambiente
        .clk(_if.clk),
        .reset(_if.reset),
        .pndng(_if.pndng),
        .push(_if.push),
        .pop(_if.pop),
        .D_pop(_if.D_pop),
        .D_push(_if.D_push)
    );

    initial begin
        // Aca le doy inicio al test
        clk = 0;
        t0 = new();
        t0._if = _if;
        t0.env_inst.driver_inst.vif = _if;
        fork
            t0.run();
        join_none
    end

    always @(posedge clk) begin
        if ($time > 100000) begin
            $display("Test_bench: Tiempo limite alcanzado, fin de la prueba");
            $finish;
        end
    end
endmodule