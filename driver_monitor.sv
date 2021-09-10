class driver;
    // Variables
    virtual ctrl_if #() vif;
    trans_ctrl_mbx agnt_drv_mbx;
    trans_ctrl_mbx mon_chkr_mbx;
    int espera;

    task run();
        $display("[%g] El se inicializa el driver", $time);
        @(posedge vif.clk);
        vif.rst = 1;
        @(posedge vif.clk);
        forever begin
            trans_ctrl #(.width(width)) trans;
            vif.push = 0;
            vif.pop = 0;
            vif.dato = 0;
            vif.rst = 0;
            $display("[%g] El driver espera una transaccion", $time);
            espera = 0;
            @(posedge vif.clk);
            agnt_drv_mbx.get(trans);
        end
    endtask
endclass //driver

class monitor;
    function new();
        
    endfunction //new()
endclass //monitor