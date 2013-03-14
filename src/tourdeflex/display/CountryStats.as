package tourdeflex.display
{
public class CountryStats
{
    public function CountryStats( country:String )
    {
        this.country = country;
    }

    public var country:String;

    [Bindable]
    public var visits:int;
}
}
