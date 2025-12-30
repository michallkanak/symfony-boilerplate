<?php

namespace App\Tests;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class ApplicationAvailabilityTest extends WebTestCase
{
    /**
     * @dataProvider urlProvider
     */
    public function testPageIsSuccessful(string $url): void
    {
        $client = self::createClient();
        $client->request('GET', $url);

        $this->assertResponseIsSuccessful();
    }

    /**
     * @return array<int, array<string>>
     */
    public static function urlProvider(): array
    {
        return [
            ['/admin/login'],
            // Add more application URLs here as you create them
            // Example: ['/about'],
        ];
    }
}
