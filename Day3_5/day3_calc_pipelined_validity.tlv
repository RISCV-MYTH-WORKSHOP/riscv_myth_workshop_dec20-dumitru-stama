\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc
      @1
         $reset = *reset;
         $cnt = $reset ? 1: >>1$cnt + 1;
         $valid = !$reset && ($cnt == 0);

      ?$valid
         @1
            //$val1[31:0] = $reset ? $rand1[3:0]: >>1$out_stage2[31:0];
            $val1[31:0] = >>1$out[31:0];
            $val2[31:0] = $rand2[3:0];

            $sum[31:0]   = $val1[31:0] + $val2[31:0];
            $diff[31:0]  = $val1[31:0] - $val2[31:0];
            $prod[31:0]  = $val1[31:0] * $val2[31:0];
            $quot[31:0]  = $val1[31:0] / $val2[31:0];

            //$cnt = $reset ? 1: >>1$cnt + 1;

         @2
            $out[31:0] = !$valid ? 0: $op[1:0] == 0 ? $sum[31:0]: $op[1:0] == 1 ? $diff[31:0]: $op[1:0] == 2 ? $prod[31:0]: $quot[31:0];

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule



