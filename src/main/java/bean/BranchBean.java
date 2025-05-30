package bean;

public class BranchBean {
    private int branchId;
    private String branchName;

    // 기본 생성자
    public BranchBean() {}

    // getter & setter
    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

}
