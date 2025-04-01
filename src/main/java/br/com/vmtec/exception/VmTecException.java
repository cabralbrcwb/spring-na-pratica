package br.com.vmtec.exception;

public class VmTecException extends RuntimeException {
    private static final long serialVersionUID = 987654321098765432L;

    public VmTecException(String message) {
        super(message);
    }
}
