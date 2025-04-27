package br.com.vmtec.exception;

public class PasswordTooShortException extends RuntimeException {

    private static final long serialVersionUID = -3774564388241934384L;
    
    private final int minimumLength;
    private final int actualLength;

    public PasswordTooShortException(int minimumLength, int actualLength) {
        super("A senha é muito curta. Tamanho mínimo: " + minimumLength + ", Tamanho atual: " + actualLength);
        this.minimumLength = minimumLength;
        this.actualLength = actualLength;
    }

    public int getMinimumLength() {
        return minimumLength;
    }

    public int getActualLength() {
        return actualLength;
    }
}