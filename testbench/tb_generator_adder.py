import random

# --- Number of Simulations ---
number_of_tests = 100
width = 64
span = 2**width

# --- Convert Integer -> Binary
def integer2binaryString (binary, length=1):
    return str(bin(binary)[2:].zfill(length))

def main():
    with (
        open("AdderTestVectorA", "w") as fA,
        open("AdderTestVectorB", "w") as fB,
        open("AdderTestVectorC", "w") as fC,
        open("AdderTestVectorR", "w") as fR,
    ):
        for _ in range(number_of_tests):
            # Generate Test Vectors
            A = random.randint(0, span-1)
            B = random.randint(0, span-1)
            C = random.randint(0, 1)
            R = A + B + C
            print(A, B, C, R)

            # Write
            fA.write(integer2binaryString(A, width))
            fB.write(integer2binaryString(B, width))
            fC.write(integer2binaryString(C, 1))
            fR.write(integer2binaryString(R, width+1))

            fA.write("\n")
            fB.write("\n")
            fC.write("\n")
            fR.write("\n")

if __name__ == "__main__":
    main()