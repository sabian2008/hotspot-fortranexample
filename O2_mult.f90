SUBROUTINE multO2(A, B, C, n)
    REAL, INTENT(IN)    :: A(n,n), B(n,n)
    REAL, INTENT(OUT)   :: C(n,n)
    INTEGER, INTENT(IN) :: n
    INTEGER             :: i, j, k

    !Zero output before starting
    C = 0
    DO j = 1, n
        DO i = 1, n
            DO k = 1, n
                C(i,j) = C(i,j) + A(i,k) * B(k,j)
            END DO
        END DO
    END DO
END SUBROUTINE multO2
