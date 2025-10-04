# mux_pins_compacto.io
    version = 3
    io_order = default
)
(iopin
    (left
        # Apenas 4 pins por lado
        (pin name="in0[0]" offset=4.0000 layer=3 width=0.2600 depth=0.2500)
        (pin name="in0[1]" space=1.5000 layer=3 width=0.2600 depth=0.2500)
        (pin name="in0[2]" space=1.5000 layer=3 width=0.2600 depth=0.2500)
        (pin name="in0[3]" space=1.5000 layer=3 width=0.2600 depth=0.2500)
    )
    (top
        # Restante dos pins no topo
        (pin name="in0[4]" offset=4.0000 layer=3 width=0.2600 depth=0.2500)
        (pin name="in1[0]" space=2.0000 layer=3 width=0.2600 depth=0.2500)
        (pin name="in1[1]" space=1.5000 layer=3 width=00.2600 depth=0.2500)
    )
    (bottom
        # Pins no fundo
        (pin name="in1[2]" offset=4.0000 layer=3 width=0.2600 depth=0.2500)
        (pin name="in1[3]" space=1.5000 layer=3 width=0.2600 depth=0.2500)
        (pin name="in1[4]" space=1.5000 layer=3 width=0.2600 depth=0.2500)
        (pin name="sel" space=3.0000 layer=3 width=0.2600 depth=0.2500)
    )
    (right
        # Saídas no lado direito
        (pin name="mux_out[0]" offset=4.0000 layer=2 width=0.2600 depth=0.2500)
        (pin name="mux_out[1]" space=1.5000 layer=2 width=0.2600 depth=0.2500)
        (pin name="mux_out[2]" space=1.5000 layer=2 width=0.2600 depth=0.2500)
        (pin name="mux_out[3]" space=1.5000 layer=2 width=0.2600 depth=0.2500)
        (pin name="mux_out[4]" space=1.5000 layer=2 width=0.2600 depth=0.2500)
    )
)
