require_relative '../lib/gorillas/city'

describe City do

  describe "#new" do
    let(:city) { City.new(70,20) }
  
    it "creates enough buildings to fill the window" do
      city.grid.each do |column|
        column.last.should_not == " "
      end
    end

    it "does not create a building higher than 3/4 the window height" do
      city.grid.each do |column|
        column[0..4].should == (0..4).map { " " }
      end
    end

    it "creates alternating graphics for buildings" do
    end

  end

end
