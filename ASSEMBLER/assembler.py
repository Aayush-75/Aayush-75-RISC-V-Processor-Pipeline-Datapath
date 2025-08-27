#opcodes
opcode_ri  = 19 #0b0010011 -> 39
opcode_rr  = 51 #0b0110011 -> 51
opcode_cb  = 99 #0b1100011 -> 99
opcode_li  = 3  #0b0000011 -> 3
opcode_ss  = 35 #0b0100011 -> 35
opcode_ru1 = 55 #0b0110111 -> 55
opcode_ru2 = 23 #0b0010111 -> 23
opcode_uj  = 111 #0b1101111 -> 111
opcode_ui  = 103 #0b1100111 -> 103

register_map = {f"x{i}": i for i in range(32)} 

with open("F:/college/CA_lab/Special Assignment/TOP/assembly_code.txt", "r") as file:
    lines = file.readlines()  # Read all lines into a list
    instructions = [line.strip() for line in lines if line.strip()]

# Step 1: First Pass - Identify Labels
label_map = {}  # Dictionary to store label addresses
address = 0  # Initialize instruction address counter

for instr in instructions:
    if ':' in instr:  
        label = instr.split(':')[0].strip()  # Extract label name
        label_map[label] = address  # Store label and its address
    else:
        address += 4  # Increment address for each instruction

# Step 2: Second Pass - Convert Instructions
memory = {}
address = 0  # Reset instruction address counter

i = 0;
memory = {}
for instr in instructions:
    instr = instr.replace(',', '').replace('(', ' ').replace(')', ' ') 
    parts = instr.split()  
    if not parts:
        continue  # Skip empty lines
###############################################################################################################################################

    operation = parts[0]
    if operation.endswith(':'):
        continue

    parts = [register_map.get(p, p) for p in parts]

    # Handle Jumps and Branches
    if operation in ["jal", "jalr", "beq", "bne", "blt", "bge"]:
        if parts[-1] in label_map:  
            label_address = label_map[parts[-1]]
            offset = label_address - address  # Compute relative offset
            parts[-1] = 4*offset  # Replace label with offset
        else:
            print(f"Error: Label '{parts[-1]}' not found!")


                                                         ###register - immediate###
################################################################################################################################################
    if operation == "addi":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"addi rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = ((imm << 20) | (rs1 << 15) | (0 << 12) | (rd << 7) | (opcode_ri << 0))
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "slti":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"slti rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = ((imm << 20) | (rs1 << 15) | (2 << 12) | (rd << 7) | (opcode_ri << 0))
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "sltiu":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"sltiu rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = ((imm << 20) | (rs1 << 15) | (3 << 12) | (rd << 7) | (opcode_ri << 0))
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "andi":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"andi rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = ((imm << 20) | (rs1 << 15) | (7 << 12) | (rd << 7) | (opcode_ri << 0))
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "ori":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"ori rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = ((imm << 20) | (rs1 << 15) | (6 << 12) | (rd << 7) | (opcode_ri << 0))
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "xori":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"xori rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = ((imm << 20) | (rs1 << 15) | (4 << 12) | (rd << 7) | (opcode_ri << 0))
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "slli":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"slli rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = (((63<<20) & (imm << 20)) | (rs1 << 15) | (1 << 12) | (rd << 7) | (opcode_ri << 0))
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "srli":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"srli rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = (((63<<20) & (imm << 20)) | (rs1 << 15) | (5 << 12) | (rd << 7) | (opcode_ri << 0))
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "srai":
        if len(parts) == 4:
            rd, rs1, imm = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); imm = int(imm);
            print(f"srai rd: {rd}, rs1: {rs1}, imm: {imm}")
            memory[i] = (((1055<<20) & ((127<<25)|imm << 20)) | (rs1 << 15) | (5 << 12) | (rd << 7) | (opcode_ri << 0)) 
            print(f"Memory: {i,memory[i]}")      
            i += 32
        else : 
            print("error : instruction format not valid")


    elif operation == "lui":
        if len(parts) == 3:
            rd, imm = parts[1], parts[2]
            rd = int(rd); imm = int(imm);
            print(f"lui rd: {rd}, imm: {imm}")
            memory[i] = ((imm << 12) | (rd << 7) | (opcode_ru1 << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "auipc":
        if len(parts) == 3:
            rd, imm = parts[1], parts[2]
            rd = int(rd); imm = int(imm);
            print(f"auipc rd: {rd}, imm: {imm}")
            memory[i] = ((imm << 12) | (rd << 7) | (opcode_ru2 << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")


                                                         ###register - register###
################################################################################################################################################

    elif operation == "add":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"add rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((0<<25) | (rs2 << 20) | (rs1 << 15) | (0 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "slt":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"slt rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((0<<25) | (rs2 << 20) | (rs1 << 15) | (2 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "sltu":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"sltu rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((0<<25) | (rs2 << 20) | (rs1 << 15) | (3 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "and":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"and rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((0<<25) | (rs2 << 20) | (rs1 << 15) | (7 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "or":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"or rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((0<<25) | (rs2 << 20) | (rs1 << 15) | (6 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "xor":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"xor rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((0<<25) | (rs2 << 20) | (rs1 << 15) | (4 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "sll":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"sll rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((0<<25) | (rs2 << 20) | (rs1 << 15) | (1 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "srl":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"srl rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((0<<25) | (rs2 << 20) | (rs1 << 15) | (5 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "sub":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"sub rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((64<<25) | (rs2 << 20) | (rs1 << 15) | (0 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "sra":
        if len(parts) == 4:
            rd, rs1, rs2 = parts[1], parts[2], parts[3]
            rd = int(rd); rs1 = int(rs1); rs2 = int(rs2);
            print(f"srai rd: {rd}, rs1: {rs1}, rs2: {rs2}")
            memory[i] = ((64<<25) | (rs2 << 20) | (rs1 << 15) | (5 << 12) | (rd << 7) | (opcode_rr << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

                                                         ###control - transfer###
################################################################################################################################################

    elif operation == "jal":
        if len(parts) == 3:
            rd, imm = parts[1], parts[2]
            rd = int(rd); imm = int(imm);
            imm = (imm & 0xFFFE);
            print(f"jal rd: {rd}, imm: {imm}")
            memory[i] = ((imm & (1 << 20)) << 10)|((imm & 0x3FF) << 20)|((imm & (1 << 11)) << 9)|((imm & 0xFF000) << 0)|((rd & 0x1F) << 7)|(opcode_uj & 0x7F)   
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "jalr":
        if len(parts) == 4:
            rd, imm, rs1 = parts[1], parts[2], parts[3]
            rd = int(rd); imm = int(imm); rs1 = int(rs1);
            print(f"jalr rd: {rd}, imm: {imm}, rs1 : {rs1}")
            memory[i] = ((imm & 0xFFF) << 20)|((rs1 & 0x1F) << 14)|(0x0 << 11)|((rd & 0x1F) << 5)|(opcode_ui & 0x7F);
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "beq":
        if len(parts) == 4:
            rs1, rs2, imm = parts[1], parts[2], parts[3]
            rs1 = int(rs1); rs2 = int(rs2); imm = int(imm);
            imm = (imm & 0xFFFE);
            print(f"beq rs1: {rs1}, rs2: {rs2}, imm : {imm}")
            memory[i] = (((imm & 0x1000) << 31) | ((imm & 0x7E0) << 25) | ((rs2 & 0x1F) << 20) | ((rs1 & 0x1F)  << 15) | (0 << 12) | (((imm & 0x1E)>>1) << 8) | ((imm & 800) << 7) | (opcode_cb << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")
    
    elif operation == "bne":
        if len(parts) == 4:
            rs1, rs2, imm = parts[1], parts[2], parts[3]
            rs1 = int(rs1); rs2 = int(rs2); imm = int(imm);
            imm = (imm & 0xFFFE);
            print(f"bne rs1: {rs1}, rs2: {rs2}, imm : {imm}")
            memory[i] = (((imm & 0x1000) << 31) | ((imm & 0x7E0) << 25) | ((rs2 & 0x1F) << 20) | ((rs1 & 0x1F)  << 15) | (1 << 12) | (((imm & 0x1E)>>1) << 8) | ((imm & 800) << 7) | (opcode_cb << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "blt":
        if len(parts) == 4:
            rs1, rs2, imm = parts[1], parts[2], parts[3]
            rs1 = int(rs1); rs2 = int(rs2); imm = int(imm);
            imm = (imm & 0xFFFE);
            print(f"blt rs1: {rs1}, rs2: {rs2}, imm : {imm}")
            memory[i] = (((imm & 0x1000) << 31) | ((imm & 0x7E0) << 25) | ((rs2 & 0x1F) << 20) | ((rs1 & 0x1F)  << 15) | (4 << 12) | (((imm & 0x1E)>>1) << 8) | ((imm & 800) << 7) | (opcode_cb << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "bltu":
        if len(parts) == 4:
            rs1, rs2, imm = parts[1], parts[2], parts[3]
            rs1 = int(rs1); rs2 = int(rs2); imm = int(imm);
            imm = (imm & 0xFFFE);
            print(f"bltu rs1: {rs1}, rs2: {rs2}, imm : {imm}")
            memory[i] = (((imm & 0x1000) << 31) | ((imm & 0x7E0) << 25) | ((rs2 & 0x1F) << 20) | ((rs1 & 0x1F)  << 15) | (6 << 12) | (((imm & 0x1E)>>1) << 8) | ((imm & 800) << 7) | (opcode_cb << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "bge":
        if len(parts) == 4:
            rs1, rs2, imm = parts[1], parts[2], parts[3]
            rs1 = int(rs1); rs2 = int(rs2); imm = int(imm);
            print(f"bge rs1: {rs1}, rs2: {rs2}, imm : {imm}")
            memory[i] = (((imm >> 12) & 1) << 31 | ((imm >> 5) & 0x3F) << 25 | ((rs2 & 0x1F) << 20) | ((rs1 & 0x1F) << 15) | (5 << 12) | ((imm >> 1) & 0xF) << 8 | ((imm >> 11) & 1) << 7 | (opcode_cb))            
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "bgeu":
        if len(parts) == 4:
            rs1, rs2, imm = parts[1], parts[2], parts[3]
            rs1 = int(rs1); rs2 = int(rs2); imm = int(imm);
            print(f"bgeu rs1: {rs1}, rs2: {rs2}, imm : {imm}")
            memory[i] = (((imm & 0x1000) << 31) | ((imm & 0x7E0) << 25) | ((rs2 & 0x1F) << 20) | ((rs1 & 0x1F)  << 15) | (7 << 12) | (((imm & 0x1E)>>1) << 8) | ((imm & 800) << 7) | (opcode_cb << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

                                                         ###load - store###
################################################################################################################################################

    elif operation == "lw":
        if len(parts) == 4:
            rd, imm, rs1 = parts[1], parts[2], parts[3]
            rd = int(rd); imm = int(imm); rs1 = int(rs1);
            print(f"lw rd: {rd}, rs1: {rs1}, imm : {imm}")
            memory[i] = (((imm & 0xFFF) << 20) | ((rs1 & 0x1F) << 15) | (2<< 12) | ((rd & 0x1F) << 7) | (opcode_li << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")
    
    elif operation == "lh":
        if len(parts) == 4:
            rd, imm, rs1 = parts[1], parts[2], parts[3]
            rd = int(rd); imm = int(imm); rs1 = int(rs1);
            print(f"lh rd: {rd}, rs1: {rs1}, imm : {imm}")
            memory[i] = (((imm & 0xFFF) << 20) | ((rs1 & 0x1F) << 15) | (1<< 12) | ((rd & 0x1F) << 7) | (opcode_li << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "lhu":
        if len(parts) == 4:
            rd, imm, rs1 = parts[1], parts[2], parts[3]
            rd = int(rd); imm = int(imm); rs1 = int(rs1);
            print(f"lhu rd: {rd}, rs1: {rs1}, imm : {imm}")
            memory[i] = (((imm & 0xFFF) << 20) | ((rs1 & 0x1F) << 15) | (5<< 12) | ((rd & 0x1F) << 7) | (opcode_li << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "lb":
        if len(parts) == 4:
            rd, imm, rs1 = parts[1], parts[2], parts[3]
            rd = int(rd); imm = int(imm); rs1 = int(rs1);
            print(f"lb rd: {rd}, rs1: {rs1}, imm : {imm}")
            memory[i] = (((imm & 0xFFF) << 20) | ((rs1 & 0x1F) << 15) | (0<< 12) | ((rd & 0x1F) << 7) | (opcode_li << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "lbu":
        if len(parts) == 4:
            rd, imm, rs1 = parts[1], parts[2], parts[3]
            rd = int(rd); imm = int(imm); rs1 = int(rs1);
            print(f"lbu rd: {rd}, rs1: {rs1}, imm : {imm}")
            memory[i] = (((imm & 0xFFF) << 20) | ((rs1 & 0x1F) << 15) | (2<< 12) | ((rd & 0x1F) << 7) | (opcode_li << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "sw":
        if len(parts) == 4:
            rs2, imm, rs1 = parts[1], parts[2], parts[3]
            rs2 = int(rs2); imm = int(imm); rs1 = int(rs1);
            print(f"sw rs2: {rs2}, rs1: {rs1}, imm : {imm}")
            memory[i] = (((imm >> 5) & 0x7F) << 25 | ((rs2 & 0x1F) << 20) |  ((rs1 & 0x1F) << 15) |   (2 << 12) |  ((imm & 0x1F) << 7) |   opcode_ss )
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "sh":
        if len(parts) == 4:
            rs2, imm, rs1 = parts[1], parts[2], parts[3]
            rs2 = int(rs2); imm = int(imm); rs1 = int(rs1);
            print(f"sw rs2: {rs2}, rs1: {rs1}, imm : {imm}")
            memory[i] = (((imm & 0xFE0)  << 25) | ((rs2 & 0x1F) << 20) | ((rs1 & 0x1F)  << 15) | (1 << 12) | ((imm & 0x1F) << 7) | (opcode_ss << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")

    elif operation == "sb":
        if len(parts) == 4:
            rs2, imm, rs1 = parts[1], parts[2], parts[3]
            rs2 = int(rs2); imm = int(imm); rs1 = int(rs1);
            print(f"sw rs2: {rs2}, rs1: {rs1}, imm : {imm}")
            memory[i] = (((imm & 0xFE0)  << 25) | ((rs2 & 0x1F) << 20) | ((rs1 & 0x1F)  << 15) | (0 << 12) | ((imm & 0x1F) << 7) | (opcode_ss << 0))
            print(f"Memory: {i,memory[i]}")
            i += 32
        else : 
            print("error : instruction format not valid")


                                                                ###ecall - breakpoints###
################################################################################################################################################
##
##
##
##
##
##

    else : 
        print("error : instruction not valid")
    
with open("F:/college/CA_lab/Special Assignment/TOP/flash_data.txt", "w") as f:
    max_address = 2048  # Define the memory limit
    step = 32  # Step size for addresses
    
    for address in range(0, max_address, step):
        value = memory.get(address, 0)  # Get value if present, else default to 0
        f.write(f"{value:08X}\n")  # Write the value as an 8-digit hexadecimal value (uppercase)



f.close()