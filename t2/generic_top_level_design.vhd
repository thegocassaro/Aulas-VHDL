--the entity is like a mold we can create to state the inputs and outputs of any integrated circuit
entity eq_generic is

    port(

        input_a : in std_logic_vector (3 downto 0);
        input_b : in std_logic_vector (3 downto 0);
        output_ab : out std_logic_vector (4 downto 0) 

    );

end;

--the architecture is what we utilize to say whats going to happen inside an entity (the actual connections and logical equations - hardware) 
architecture does_something of eq_generic is

    --these are the architecture declarations (subtype / signal)
    --we can declare internal signals, components of other designs, constants, ... , all to be used in this architecture
    
        --in subtype we can save a data type (std_logic_vector (4 downto 0)) in this logic_vector_size "variable" (creating a special data type)
    subtype logic_vector_size is std_logic_vector (4 downto 0);

        --in signal we can declare an internal signal of any kind (result, which has the data type logic_vector_size)
    signal internal_result : logic_vector_size;

    begin

        internal_result <= input_a + input_b;
        output_ab <= internal_result;

    end does_something;
            
--the same entity can have multiple architectures, for example:

--arch_a can be an adder with 2 inputs of 4 bits and 1 output of 5 bits
--arch_b can be a subtractor with 2 inputs of 4 bits and 1 output of 5 bits

--both arch_a and arch_b can make use of the same entity with these specific ins and outs

--note: by default the entity will make use of the last architecture declared
--but you can instantiate the entity, having each use a different architecture at a time, which is pretty cool