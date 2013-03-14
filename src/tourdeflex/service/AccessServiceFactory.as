package tourdeflex.service
{
public class AccessServiceFactory
{
    [Factory]
    public function create():IAccessService
    {
//        return new AccessService();
        return new MockAccessService();
    }
}
}
