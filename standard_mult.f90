SUBROUTINE standard_mult(A, B, C, n)
    REAL, INTENT(IN)    :: A(n,n), B(n,n)
    REAL, INTENT(OUT)   :: C(n,n)
    INTEGER, INTENT(IN) :: n
    INTEGER             :: i
    C = MATMUL(A,B)
END SUBROUTINE standard_mult
