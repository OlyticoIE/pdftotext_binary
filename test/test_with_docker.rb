require 'minitest/autorun'

class WithDockerTest < Minitest::Test
  SETUP = begin
            `docker compose build --no-cache`
          end

  def test_debian
    assert_match(/pdftotext version [0-9.]{7,10}/, `docker compose run --rm debian 2>&1`.strip)
  end
end
