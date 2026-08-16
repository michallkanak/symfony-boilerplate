<?php

namespace App\Tests;

use App\Entity\User;
use PHPUnit\Framework\Attributes\DataProvider;
use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class ApplicationAvailabilityTest extends WebTestCase
{
    #[DataProvider('urlProvider')]
    public function testPageIsSuccessful(string $url): void
    {
        $client = self::createClient();
        $client->request('GET', $url);

        $this->assertResponseIsSuccessful();
    }

    public function testAdminDashboardRendering(): void
    {
        $client = self::createClient();
        /** @var \Doctrine\ORM\EntityManagerInterface $em */
        $em = static::getContainer()->get('doctrine')->getManager();
        $userRepo = $em->getRepository(User::class);
        $user = $userRepo->findOneBy(['email' => 'admin@test.com']);
        if (!$user) {
            $user = new User();
            $user->setEmail('admin@test.com');
            $user->setRoles(['ROLE_ADMIN']);
            $user->setPassword('test');
            $em->persist($user);
            $em->flush();
        }

        $client->loginUser($user);
        $client->request('GET', '/admin');
        $this->assertResponseIsSuccessful();
    }

    /**
     * @return array<int, array<string>>
     */
    public static function urlProvider(): array
    {
        return [
            ['/admin/login'],
        ];
    }
}
