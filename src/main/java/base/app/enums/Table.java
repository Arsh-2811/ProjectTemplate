package base.app.enums;

public enum Table {
    TEMPORARY,
    PERMANENT;

    @Override
    public String toString() {
        switch (this) {
            case PERMANENT : return "PermanentRecord";
            case TEMPORARY : return "TemporaryRecord";
            default : return super.toString();
        }
    }
}